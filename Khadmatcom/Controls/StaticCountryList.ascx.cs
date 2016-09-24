using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Khadmatcom.controls
{
    public partial class StaticCountryList : ControlBase
    {
        public string CssClass
        {
            get { return ddlCountries.CssClass; }
            set { ddlCountries.CssClass = value; }
        }

        public string SelectedCountryName
        {
            get { return ddlCountries.SelectedItem.Text; }
        }

        public int SelectedCountry
        {
            get
            {
                return int.Parse(ddlCountries.SelectedValue);
            }
            set
            {
                ddlCountries.SelectedValue = value.ToString();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}