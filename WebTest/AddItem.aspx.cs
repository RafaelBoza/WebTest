using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebTest.Models;

namespace WebTest
{
    public partial class AddItem : System.Web.UI.Page
    {
        MyContext context;
        string tipo = "error";
        string Msj = string.Empty;
        string titulo = "Validation Error";
        protected void Page_Load(object sender, EventArgs e)
        {
            context = new MyContext();
            BindGridView();
        }

        private void ClearControls()
        {
            Name.Text = string.Empty;
            Price.Text = string.Empty;
        }

        private void BindGridView()
        {
            GvItems.DataSource = null;
            GvItems.Visible = true;
            GvItems.DataSource = context.Items.Select((x) => new { x.Price, x.Name }).ToList();
            GvItems.DataBind();            
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if(string.IsNullOrEmpty(Name.Text))
            {              
                Msj = "The item name cannot be empty";              
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }
            if(string.IsNullOrEmpty(Price.Text))
            {                              
                Msj = "The item price cannot be empty";               
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }
            if (Price.Text.Any(x => !char.IsDigit(x) && (x != '.') && (x != ',')))
            {              
                Msj = "The price must be a valid data type";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }
            if (decimal.Parse(Price.Text) <= 0)
            {              
                Msj = "The price must be over 0";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }

            Item item = new Item();
            item.Name = Name.Text.Trim();
            decimal temp_price = 0;
            if(!decimal.TryParse(Price.Text, out temp_price))
            {
                Msj = "The price must be a valid data type";                
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }
            item.Price = temp_price;
            if(context.Items.Any(x => x.Name == item.Name))
            {                
                Msj = "There is already an Item with the same name";             
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }
            context.Items.Add(item);
            try
            {
                context.SaveChanges();
                ClearControls();
            }
            catch (Exception ex)
            {
                Msj = ex.Message;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }
            BindGridView();
            
          
        }
    }
}