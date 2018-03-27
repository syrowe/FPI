<%@ Assembly Name="FPI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=2e092737738f74c2" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="VB" AutoEventWireup="true" CodeBehind="ExcludedAll.aspx.vb" Inherits="FPI.Layouts.FPI.ExcludedAll" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
<link rel="Stylesheet" type="text/css" href="/_layouts/ML_Webparts/scripts/Styles.css" />
<script type="text/javascript">

</script>

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <p>Once you have made your alterations add any new clients to the current FPI batch by reviewing their grouping and other settings <a href="../FPI/NewFPIAll.aspx">here</a></p>
       <asp:DropDownList ID="ManagerDDL" runat="server" CssClass="input" AutoPostBack="True" AppendDataBoundItems="true"
                    DataSourceID="ManagerSQL" DataTextField="StaffName" 
                    DataValueField="StaffUser" OnDataBound="ManagerDDL_DataBound">
        </asp:DropDownList>
    <asp:GridView ID="FPIGv" runat="server" AllowSorting="true" DataSourceID="FPINewSQL" AutoGenerateColumns="false" DataKeyNames="CRMCLientID" CssClass="bordered" AutoGenerateEditButton="true" 
        AllowPaging="true" PageSize="15">
        <Columns>
            <asp:TemplateField HeaderText="Clientcode" sortExpression="Clientcode" >
                <ItemTemplate>
                    <asp:HyperLink ID="Codehyper" runat="server" Text='<%# Eval("clientcode") %>' NavigateUrl='<%# Eval("clientcode", "/sites/mlintranet/_Layouts/ML_Webparts/Client.aspx?Clientcode={0}") %>'></asp:HyperLink>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:HyperLink ID="Codehyper" runat="server" Text='<%# Eval("clientcode") %>' NavigateUrl='<%# Eval("clientcode", "/sites/mlintranet/_Layouts/ML_Webparts/Client.aspx?Clientcode={0}") %>'></asp:HyperLink>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="name" SortExpression="name" HeaderText="Name" ReadOnly="true" />
            <asp:BoundField DataField="Manager" SortExpression="Manager" HeaderText="Manager" ReadOnly="true" />
            <asp:TemplateField HeaderText="Embargo" >
                <ItemTemplate>
                    <asp:CheckBox ID="EmbargoCheck1" runat="server" Enabled="false" Checked='<%# Eval("FPI_embargo") %>' />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="EmbargoCheck2" runat="server" Enabled="true" Checked='<%# Bind("FPI_embargo") %>' />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="fpi_embargo_reason" SortExpression="FPI_embargo_reason" HeaderText="Reason"/>
            <asp:TemplateField HeaderText="FPI Size" >
                <ItemTemplate>
                    <asp:Label ID="fpisizelbl" runat="server" Text='<%# Eval("fpi_size") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="fpisizeddl" AutoPostBack="false" runat="server" CssClass="input" SelectedValue='<%# Bind("fpi_size") %>'>
                        <asp:ListItem></asp:ListItem>
                        <asp:ListItem Value="NonBusiness">Non-Business</asp:ListItem>
                        <asp:ListItem Value="Small">Small</asp:ListItem>
                        <asp:ListItem Value="Large">Large</asp:ListItem>
                        <asp:ListItem Value="VLarge">Very Large</asp:ListItem>
                        <asp:ListItem Value="Enormous">Enormous</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Client Type">
                <ItemTemplate>
                    <asp:Label ID="typelbl" runat="server" Text='<%# Eval("clienttype") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="EntityDDL" runat="server" AutoPostBack="True" CssClass="input"
                        DataSourceID="EntitySql" DataTextField="OwnerName" DataValueField="OwnerIndex" 
                         AppendDataBoundItems="true" SelectedValue='<%# Bind("clienttype") %>'>
                         <asp:ListItem></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Salutation">
                <ItemTemplate>
                    <asp:Label ID="sallbl" runat="server" Text='<%# Eval("fpisalutation") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="SalTB" runat="server" CssClass="input" Text='<%# Bind("FPISalutation") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Addressee">
                <ItemTemplate>
                    <asp:Label ID="addrlbl" runat="server" Text='<%# Eval("fpiaddressee") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="addrTB" runat="server" CssClass="input" Text='<%# Bind("FPIaddressee") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:Label ID="errorlbl" runat="server" Text=""></asp:Label>
    <asp:SqlDataSource ID="EntitySql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" 
        SelectCommand="ICAF_EntityTypes" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="FPINewSQL" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" 
        OldValuesParameterFormatString="original_{0}" ConflictDetection="OverwriteChanges"
        SelectCommand="Select CRMClientID, Clientcode, name, manager, clienttype, fpi_size, FPISalutation, FPIAddressee, fpi_embargo, modified_user_id, fpi_embargo_reason from MainClient where fpi_embargo=1 and client_status in ('Active', 'New') and manager_user=@manager order by clientcode" SelectCommandType="Text"
        UpdateCommand="Update MainClient set clienttype=@clienttype, fpi_size=@fpi_size, fpisalutation=@fpisalutation, fpiaddressee=@fpiaddressee, fpi_embargo=@fpi_embargo, modified_user_id=@modified_user_id, fpi_embargo_reason=@fpi_embargo_reason where crmclientid=@original_CrmClientID">
    <UpdateParameters>
        <asp:Parameter Name="clienttype" Type="String" />
        <asp:Parameter Name="Fpi_size" Type="String" />
        <asp:Parameter Name="fpisalutation" Type="String" />
        <asp:Parameter Name="fpiaddressee" Type="String" />
        <asp:Parameter Name="fpi_embargo" Type="boolean" />
        <asp:Parameter Name="fpi_embargo_reason" Type="String" />
        <asp:ControlParameter Name="modified_user_id" ControlID="userlbl" PropertyName="Text" Type="String" />
        <asp:Parameter Name="original_CRMCLientID" Type="String" />
    </UpdateParameters>
    <SelectParameters>
	    <asp:ControlParameter Name="manager" ControlID="ManagerDDL" PropertyName="SelectedValue" Type="String" />
    </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="LeadsSql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" 
        SelectCommand="Select clientcode, CRMClientID from FPINewView where isLead=1" SelectCommandType="Text">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="ManagerSql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" SelectCommand="ICAF_Managers" SelectCommandType="StoredProcedure"
        ProviderName="System.Data.SqlClient">
    </asp:SqlDataSource>
        <br />
    <asp:Label ID="UserLbl" runat="server" Text="" Visible="false"></asp:Label>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
FPI Excluded Clients
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
FPI Excluded Clients
</asp:Content>
