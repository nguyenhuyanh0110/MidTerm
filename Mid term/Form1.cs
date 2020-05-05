using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Mid_term
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        midcoquanDataContext db = new midcoquanDataContext();
        string trangthai = "";
        private void Form1_Load(object sender, EventArgs e)
        {
            //load ds mã bộ phận
            cbbBP.DataSource = db.BoPhans.OrderBy(p => p.TENBP);
            cbbBP.DisplayMember = "TenBP"; //hiện danh sách bộ phận
            cbbBP.ValueMember = "MaBP"; //lập giá trị để quản lý
            cbbBP.SelectedIndex = 0; // giá trị index ban đầu là 0
            loadlaiDS();
        }

        private void loadlaiDS()
        {
            string MaBP = cbbBP.SelectedValue.ToString(); //load danh sách khi chưa chọn ccb
            loadDSBPtheoDV(MaBP);
        }
        private void loadDSBPtheoDV(string MaBP)
        {
            dgvBP.DataSource = db.DONVIs.Where(p => p.MABP == MaBP).Select(p => new
            {
                p.MADV,
                p.TENDV,
                p.NGAYTL,
                p.MABP
            });
        }

        private void cbbBP_SelectedIndexChanged(object sender, EventArgs e)
        {
            //chọn cbbMaBP để lấy dữ liệu
            string MaBP = cbbBP.SelectedValue.ToString();
            // load dgv theo dữ liệu cbb
            loadDSBPtheoDV(MaBP);
        }
        
        private void dgvBP_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            int click = e.RowIndex; //lấy giá trị click chuột ở dgv
            if (click >= 0) // giá trị click chuột >=0 ở content
            {
                string MaDV = dgvBP.Rows[click].Cells[0].Value.ToString(); //chuyển dữ liệu chỗ click chuột thành string
                DONVI dv = db.DONVIs.Where(p => p.MADV == MaDV).SingleOrDefault();
                if (dv != null) // có thông tin
                {
                    cbbBP.SelectedItem = dv.BoPhan;
                    txtMaDV.Text = dv.MADV;
                    txtTenDV.Text = dv.TENDV;
                    dtNgayTL.Value = dv.NGAYTL.Value;
                }
            }
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            DialogResult rs = MessageBox.Show("Bạn có muốn xóa dữ liệu không?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (rs == DialogResult.Yes)
            {
                string MaDV = txtMaDV.Text;
                if (MaDV != "") // có đơn vị
                {
                    DONVI dv = db.DONVIs.Where(p => p.MADV == MaDV).SingleOrDefault();
                    if (dv != null) // có dữ liệu ở dgv
                    {
                        // xử lý xóa dữ liệu
                        db.DONVIs.DeleteOnSubmit(dv); // xóa dữ liệu theo đơn vị
                        db.SubmitChanges(); // confirm xóa dữ liệu

                        // load lại ds đơn vị sau khi xóa  dữ liệu
                        string MaBP = cbbBP.SelectedValue.ToString();
                        loadDSBPtheoDV(MaBP);
                        MessageBox.Show("Xóa dữ liệu thành công");
                    }
                    else // không có dữ liệu ở dv
                    {
                        MessageBox.Show("Lỗi không tồn tại đơn vị", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            trangthai = "them";
            dienThongTin(true);
            dtNgayTL.Value = DateTime.Now.Date;
            txtMaDV.Text = txtTenDV.Text = "";
            btnSua.Enabled = false;
            btnXoa.Enabled = false;
            btnThoat.Enabled = false;
            txtMaDV.Enabled = true;
        }

        private void dienThongTin(bool bt)
        {
            txtTenDV.Enabled = bt;
            dtNgayTL.Enabled = bt;
            btnLuu.Enabled = bt;
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            txtMaDV.Enabled = false;
            trangthai = "sua";
            dienThongTin(true);
            cbbBP.Enabled = false;
            btnThem.Enabled = false;
            btnXoa.Enabled = false;
            btnThoat.Enabled = false;
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            if (trangthai == "them")
            {
                string maDV = txtMaDV.Text; // khai báo string maDV để nhập mã đơn vị
                DONVI dv = db.DONVIs.Where(p => p.MADV == maDV).SingleOrDefault(); // kiểm tra mã đơn vị
                if (dv != null) // có thông tin
                {
                    MessageBox.Show("Trùng mã đơn vị");
                    return;
                }
                else
                {
                    dv = new DONVI();
                    dv.MABP = cbbBP.SelectedValue.ToString();
                    dv.MADV = txtMaDV.Text;
                    dv.TENDV = txtTenDV.Text;
                    dv.NGAYTL = dtNgayTL.Value;

                    db.DONVIs.InsertOnSubmit(dv); // cập nhật dữ liệu
                    db.SubmitChanges(); //submit dữ liệu
                    loadlaiDS();
                    MessageBox.Show("Thêm thành công");
                }
            }
            else if (trangthai == "sua")
            {
                string maDV = txtMaDV.Text; // khai báo string maDV để nhập mã đơn vị
                DONVI dv = db.DONVIs.Where(p => p.MADV == maDV).SingleOrDefault(); // kiểm tra mã đơn vị
                if (dv != null) // có thông tin
                {
                    dv.MABP = cbbBP.SelectedValue.ToString();
                    dv.TENDV = txtTenDV.Text;
                    dv.NGAYTL = dtNgayTL.Value;

                    db.SubmitChanges(); //submit dữ liệu
                    MessageBox.Show("Sửa thành công");
                    loadlaiDS(); // load lại dữ liệu khi submit xong
                }
                else
                {
                    MessageBox.Show("Lỗi không có bộ phận");
                    return;
                }
            }
        }

        private void btnTailai_Click(object sender, EventArgs e)
        {
            trangthai = ""; //trả lại trạng thái ban đầu
            dienThongTin(false);
            loadlaiDS();
            txtMaDV.Enabled = false;
            btnLuu.Enabled = false;
            btnSua.Enabled = true;
            btnXoa.Enabled = true;
            btnThoat.Enabled = true;
            btnThem.Enabled = true;
            cbbBP.Enabled = true;
        }

        private void btnThoat_Click(object sender, EventArgs e)
        {
            DialogResult rs = MessageBox.Show("Bạn có muốn thoát không?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (rs == DialogResult.Yes)
            {
                this.Close();
            }
        }
    }
}
