import connection from "../../common/connect.js";

export const GetDetailPeople = async (req, res) => {
  const { id } = req.params;

  try {
    const [rows] = await connection.promise().query("SELECT * FROM peoples WHERE id = ?", [id]);
    if (rows.length === 0) {
      return res.status(404).json({ message: "Không tìm thấy bản ghi với ID này" });
    }
    res.status(200).json({...rows[0],images_list: rows[0]?.images_list ? JSON.parse(rows[0]?.images_list) : [] });
  } catch (error) {
    console.error("Lỗi khi lấy dữ liệu bản ghi:", error);
    res.status(500).json({ message: "Đã xảy ra lỗi khi lấy dữ liệu bản ghi" });
  }
};

export const GetAllPeople = async (req, res) => {
  try {
    const [rows] = await connection.promise().query("SELECT * FROM peoples");
    const _rows = rows.map(row => ({...row,images_list: row?.images_list ? JSON.parse(row?.images_list) : [] }))
    res.status(200).json(_rows);
  } catch (error) {
    console.error("Lỗi khi lấy dữ liệu bản ghi:", error);
    res.status(500).json({ message: "Đã xảy ra lỗi khi lấy dữ liệu bản ghi" });
  }
};

export const CreatePeople = async (req, res) => {
  const { province_id, province_name, image_url, code, name, age, price, description, sortAddress, images_list } =
    req.body;
  try {
    const [result] = await connection.promise().query(
      `INSERT INTO peoples 
        (province_id, province_name, image_url, code, name, age, price, description, sortAddress, images_list) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        province_id,
        province_name,
        image_url,
        code,
        name,
        age,
        price,
        description,
        sortAddress,
        JSON.stringify(images_list),
      ]
    );
    res.status(201).json({ message: "Thêm mới bản ghi thành công", id: result.insertId });
  } catch (error) {
    console.error("Lỗi khi thêm bản ghi:", error);
    res.status(500).json({ message: "Đã xảy ra lỗi khi thêm bản ghi" });
  }
};

export const EditPeople = async (req, res) => {
  const { id } = req.params;
  const { province_id, province_name, image_url, code, name, age, price, description, sortAddress, images_list } =
    req.body;

  try {
    const [result] = await connection.promise().query(
      `UPDATE peoples 
        SET province_id = ?, province_name = ?, image_url = ?, code = ?, name = ?, age = ?, price = ?, description = ?, sortAddress = ?, images_list = ? 
        WHERE id = ?`,
      [
        province_id,
        province_name,
        image_url,
        code,
        name,
        age,
        price,
        description,
        sortAddress,
        JSON.stringify(images_list),
        id,
      ]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Không tìm thấy bản ghi để cập nhật" });
    }
    res.status(200).json({ message: "Cập nhật bản ghi thành công" });
  } catch (error) {
    console.error("Lỗi khi cập nhật bản ghi:", error);
    res.status(500).json({ message: "Đã xảy ra lỗi khi cập nhật bản ghi" });
  }
};

export const DeletePeople = async (req, res) => {
  const { id } = req.params;

  try {
    const [result] = await connection.promise().query("DELETE FROM peoples WHERE id = ?", [id]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Không tìm thấy bản ghi để xóa" });
    }
    res.status(200).json({ message: "Xóa bản ghi thành công" });
  } catch (error) {
    console.error("Lỗi khi xóa bản ghi:", error);
    res.status(500).json({ message: "Đã xảy ra lỗi khi xóa bản ghi" });
  }
};
