<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="VB" AutoEventWireup="true" CodeBehind="MyFPIAll.aspx.vb" Inherits="FPI.Layouts.FPI.MyFPIAll" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <link rel="Stylesheet" type="text/css" href="/_layouts/ML_Webparts/scripts/Styles.css" />
    <script type="text/javascript">

        function openDialog(DialogName, id, title) {
            var options = {
                url: DialogName + "?id=" + id,
                dialogReturnValueCallback: CloseWindowCallback,
                width: 400,
                height: 400,
                title: title
             };
            SP.UI.ModalDialog.showModalDialog(options);
            return false;
        }

        function CloseWindowCallback(dialogresult, returnValue) {
            {
                SP.UI.ModalDialog.RefreshPage(SP.UI.DialogResult.OK);
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
       <asp:DropDownList ID="ManagerDDL" runat="server" CssClass="input" AutoPostBack="True"
                    DataSourceID="ManagerSQL" DataTextField="StaffName" AppendDataBoundItems="true" 
                    DataValueField="StaffUser" OnDataBound="ManagerDDL_DataBound">
           <asp:ListItem Text="Show All" Value="All"></asp:ListItem>
        </asp:DropDownList> 

    <br />
    <asp:Label ID="UserLabel" runat="server" Text="" Visible="false"></asp:Label>
    <asp:GridView ID="SPGrid" runat="server" AllowSorting="true" DataSourceID="CCHSql" AutoGenerateColumns="false" DataKeyNames="id" CssClass="bordered" AutoGenerateEditButton="true" 
        AllowPaging="true" PageSize="15" >
        <Columns>
            <asp:TemplateField HeaderText="Code" sortExpression="Clientcode">
                <ItemTemplate>
                    <asp:HyperLink ID="hyperDetails" runat="server" NavigateUrl='<%# "~/_Layouts/ML_Webparts/Client.aspx?Clientcode=" + HttpUtility.UrlDecode(Eval("clientcode").ToString())  %>' Text='<%# Eval("clientcode").ToString() %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="lead_name" HeaderText="Name" SortExpression="lead_name"/>				
            <asp:BoundField DataField="Invoicelines" HeaderText="Invoice Detail" ItemStyle-Wrap="true" SortExpression="invoicelines" />
            <asp:BoundField DataField="last_year" HeaderText="Taken up last year?" ItemStyle-HorizontalAlign="Center" ItemStyle-Wrap="true" SortExpression="last_year" ReadOnly="true"/>
            <asp:BoundField DataField="totalPremium" HeaderText="Total Premium" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:f2}" FooterStyle-HorizontalAlign="Right" SortExpression="totalPremium" ItemStyle-HorizontalAlign="Right"  />
            <asp:BoundField DataField="Paid" HeaderText="Paid" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:f2}" FooterStyle-HorizontalAlign="Right" SortExpression="Paid" ItemStyle-HorizontalAlign="Right"  />
            <asp:BoundField DataField="Balance" HeaderText="Balance" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:f2}" FooterStyle-HorizontalAlign="Right" SortExpression="Balance" ItemStyle-HorizontalAlign="Right"  />
            <asp:TemplateField HeaderText="Notes">
                <ItemTemplate>
                    <a href="javascript:;" onclick="openDialog('AddNote.aspx' , '<%# Eval("id") %>' , 'Add Note');" ><%# Eval("notes").ToString()%></a> 
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
    <asp:Button ID="ExportBtn1" runat="server" Text="Export to Excel" />
    <br />
  
    <!--SQL for billing data -->
    <asp:SqlDataSource ID="CCHSql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" 
        SelectCommand="select id, clientcode, lead_name, manager, invoicelines, case when last_year=1 then 'Yes' else 'No' end as last_year, totalpremium, paid, (totalpremium-paid) as Balance, (Substring(ISNULL(notes, ''), 0, 15) + '...') as notes from FPIView where (totalpremium-paid)<>0 and ((@user = 'All') or (manager_user= @user)) order by clientcode" >
        <SelectParameters>
            <asp:ControlParameter Name="user" ControlID="ManagerDDL" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="ManagerSql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" SelectCommand="ICAF_Managers" SelectCommandType="StoredProcedure"
        ProviderName="System.Data.SqlClient">
    </asp:SqlDataSource>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Outstanding Clients
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Outstanding Clients
</asp:Content>
