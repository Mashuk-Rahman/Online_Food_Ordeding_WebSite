using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Food.User
{
    public partial class Invoice : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader dr, dr1;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //DataTable GetOrderDetails()
        //{

        //}

    }
}