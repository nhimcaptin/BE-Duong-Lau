import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import connection from "../../common/connect.js";

export const register = async (req, res) => {
  const { username, password, email, numberPhone, firstName, lastName } = req.body;

  try {
    const [existingUser] = await connection.promise().query("SELECT * FROM users WHERE username = ?", [username]);
    if (existingUser.length > 0) {
      return res.status(400).json({ message: "Tên người dùng hoặc email đã tồn tại" });
    }

    const salt = bcrypt.genSaltSync(10);
    const hash = bcrypt.hashSync(password, salt);

    await connection
      .promise()
      .query(
        "INSERT INTO users (username, password, email, number_phone, first_name, last_name) VALUES (?, ?, ?, ?, ?, ?)",
        [username, hash, email, numberPhone, firstName, lastName]
      );

    res.status(201).json({ message: "Đăng ký thành công" });
  } catch (error) {
    console.error("Lỗi khi đăng ký người dùng:", error);
    res.status(500).json({ message: "Lỗi khi đăng ký" });
  }
};

export const login = async (req, res) => {
  const { username, password } = req.body;
  try {
    const [user] = await connection.promise().query("SELECT * FROM users WHERE username = ?", [username]);
    const _user = user[0];
    if (!_user) {
      return res.status(400).json({ message: "Tên đăng nhập không tồn tại" });
    }

    const isPasswordValid = await bcrypt.compare(password, _user.password);
    if (!isPasswordValid) {
      return res.status(400).json({ message: "Mật khẩu không đúng." });
    }

    const token = jwt.sign({ userId: _user.id }, process.env.SECURITY_KEY, { expiresIn: "12h" });
    res.json({ message: "Đăng nhập thành công", accessToken: token });
  } catch (error) {
    console.error("Lỗi khi đăng nhập:", error);
    res.status(500).json({ message: "Lỗi khi đăng nhập" });
  }
};

export const getCurrentUser = async (req, res, next) => {
  try {
    const decoded = jwt.verify(req.header("authorization").replace("Bearer ", ""), process.env.SECURITY_KEY);
    const [user] = await connection.promise().query("SELECT * FROM users WHERE id = ?", [decoded.userId]);
    const _user = {
      ...user[0],
    };
    delete _user.id;
    delete _user.password;
    return res.status(200).json(_user);
  } catch (error) {
    return res.status(500).json({message: "Token hết hạn rồi đừng call nữa"});
    next(error);
  }
};
