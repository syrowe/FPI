<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="VB" AutoEventWireup="true" CodeBehind="Notify.aspx.vb" Inherits="FPI.Layouts.FPI.Notify" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
<script type="text/javascript">

        function SelectAllCheckboxes(spanChk) {

            // Added as ASPX uses SPAN for checkbox
            var oItem = spanChk.children;
            var theBox = (spanChk.type == "checkbox") ?
                spanChk : spanChk.children.item[0];
            xState = theBox.checked;
            elm = theBox.form.elements;

            for (i = 0; i < elm.length; i++)
                if (elm[i].type == "checkbox" &&
                  elm[i].id != theBox.id) {
                    //elm[i].click();
                    if (elm[i].checked != xState)
                        elm[i].click();
                    //elm[i].checked=xState;
                }
        }
</script>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <asp:GridView ID="FPIGv" runat="server" AllowSorting="true" DataSourceID="CCHSQL" AutoGenerateColumns="false" DataKeyNames="detailID" CssClass="bordered" >
          <Columns>
                <asp:BoundField DataField="Client_code" HeaderText="Code" ControlStyle-Width="150px" ItemStyle-Width="150px" SortExpression="Client_code" />
                <asp:BoundField DataField="client_name" HeaderText="Name" SortExpression="client_name"/>				
				<asp:Boundfield DataField="client_type" HeaderText="Type" SortExpression="client_type" />
				<asp:BoundField DataField="Client_size" HeaderText="Size" SortExpression="client_size" />
                <asp:BoundField DataField="PaidDate" HeaderText="Date Paid" SortExpression="PaidDate" DataFormatString="{0:d}" />
                <asp:BoundField DataField="Line" HeaderText="Premium" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:f2}" FooterStyle-HorizontalAlign="Right" SortExpression="Line" ItemStyle-HorizontalAlign="Right"  />
                <asp:BoundField DataField="Paid" HeaderText="Paid" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:f2}" FooterStyle-HorizontalAlign="Right" SortExpression="Paid" ItemStyle-HorizontalAlign="Right"  />
                <asp:BoundField DataField="Balance" HeaderText="Balance" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:f2}" FooterStyle-HorizontalAlign="Right" SortExpression="Balance" ItemStyle-HorizontalAlign="Right"  />
                <asp:TemplateField HeaderText="Sent" >
                    <HeaderTemplate>
                    <asp:Label ID="sentlbl" runat="server" Text="Select All"></asp:Label>
                      <input id="chkAll" onclick="javascript: SelectAllCheckboxes(this);" 
                                  runat="server" type="checkbox" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="ReviewCheck" runat="server" Enabled="true" />
                    </ItemTemplate>
                </asp:TemplateField>             
           </Columns>
        </asp:GridView>
    <br />
    <asp:Button ID="ExportBtn1" runat="server" Text="Export to Excel" />
    <br />
    <br />
    <asp:Button ID="UpdateBtn" Enabled="false" runat="server" Text="Update Submission date" />
    <!--SQL for billing data -->
<asp:SqlDataSource ID="CCHSql" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" 
    ConflictDetection="OverwriteChanges" OldValuesParameterFormatString="original_"
    SelectCommand="FPI_CCHReport" SelectCommandType="StoredProcedure"
    UpdateCommand="update FPIView set reportedon=GETDATE(), modified_user_id=@user where id=@id">
    <SelectParameters>
        <asp:Parameter Name="WithUpdate" DefaultValue="0" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="PermittedSQL" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>"
    SelectCommand="Select count(parameter) as permitted from settings where parameter='FPIAdmin' and value like '%' + @user + '%'" >
    <SelectParameters>
        <asp:ControlParameter Name="user" Type="string" ControlID="UserLbl" />
    </SelectParameters>
</asp:SqlDataSource>

<br />
<asp:Label ID="UserLbl" runat="server" Text="" Visible="false"></asp:Label>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
CCH Submission
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
CCH Submission
</asp:Content>
