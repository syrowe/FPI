<%@ Assembly Name="FPI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=2e092737738f74c2" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="VB" AutoEventWireup="true" CodeBehind="NewFPIAll.aspx.vb" Inherits="FPI.Layouts.FPI.NewFPIAll" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
<link rel="Stylesheet" type="text/css" href="/_layouts/ML_Webparts/scripts/Styles.css" />
<script type="text/javascript">

    function SelectAllCheckboxes(spanChk) {

        var oItem = spanChk.children;
        var theBox = (spanChk.type == "checkbox") ?
        spanChk : spanChk.children.item[0];
        xState = theBox.checked;
        elm = theBox.form.elements;

        for (i = 0; i < elm.length; i++)
            if (elm[i].type == "checkbox" && elm[i].id != theBox.id)
            {
                if (elm[i].enabled = true)
                {
                    if (elm[i].checked != xState)
                        elm[i].click();
                }

            }
    }

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
            alert('Client exlcuded from FPI click update or Cancel to continue');
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
  

    <asp:GridView ID="FPIGv" runat="server" AllowSorting="true" DataSourceID="FPINewSQL" AutoGenerateColumns="false" DataKeyNames="CRMCLientID" CssClass="bordered" AutoGenerateEditButton="true"
        AllowPaging="true" PageSize="15"  >
        <Columns>
            <asp:TemplateField HeaderText="Clientcode" sortExpression="Clientcode" >
                <ItemTemplate>
                    <asp:HyperLink ID="Codehyper" runat="server" tooltip='<%# Eval("addressblock").ToString() %>' Text='<%# Eval("clientcode") %>' NavigateUrl='<%# Eval("clientcode", "/sites/mlintranet/_Layouts/ML_Webparts/Client.aspx?Clientcode={0}") %>'></asp:HyperLink>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:HyperLink ID="Codehyper" runat="server" tooltip='<%# Eval("addressblock").ToString() %>' Text='<%# Eval("clientcode") %>' NavigateUrl='<%# Eval("clientcode", "/sites/mlintranet/_Layouts/ML_Webparts/Client.aspx?Clientcode={0}") %>'></asp:HyperLink>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="name" SortExpression="name" HeaderText="Name" ReadOnly="true" />
            <asp:BoundField DataField="last_year" HeaderText="Taken up last year?" ItemStyle-HorizontalAlign="Center" ItemStyle-Wrap="true" SortExpression="last_year" ReadOnly="true"/>
            <asp:TemplateField HeaderText="Embargo" >
                <ItemTemplate>
                    <asp:CheckBox ID="EmbargoCheck1" runat="server" Enabled="false" Checked='<%# Eval("FPI_embargo") %>' />
                </ItemTemplate>
                <EditItemTemplate>
                    <a href="javascript:;" onclick="openDialog('Embargo.aspx' , '<%# Eval("CRMClientID")%>' , 'Add Reason');" >Embargo</a>
                </EditItemTemplate>
            </asp:TemplateField>
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
            <asp:TemplateField HeaderText="Make Lead" >
                <ItemTemplate>
                    <asp:CheckBox ID="LeadCheck1" runat="server" Enabled="false" Checked='<%# Eval("IsLead") %>' />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="LeadCheck2" runat="server" Enabled="true" Checked='<%# Bind("IsLead") %>' />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Lead Client" >
                <ItemTemplate>
                    <asp:Label ID="Leadlbl" runat="server" Text='<%# Eval("LeadClientCode") %>' tooltip='<%# Eval("LeadName").ToString()%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="LeadsDDL" runat="server" AutoPostBack="True" CssClass="input" 
                        DataSourceID="LeadsSql" DataTextField="client" DataValueField="CRMclientid" 
                         AppendDataBoundItems="true" SelectedValue='<%# Bind("LeadClient") %>'>
                         <asp:ListItem></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="fee" HeaderText="Est. Fee" SortExpression="fee" DataFormatString="{0:N}" ItemStyle-HorizontalAlign="Right" ReadOnly="true" />
            <asp:TemplateField HeaderText="Reviewed" >
                <HeaderTemplate>
                <asp:Label ID="addrlbl" runat="server" Text="Select All"></asp:Label>
                  <input id="chkAll" onclick="javascript:SelectAllCheckboxes(this);" 
                              runat="server" type="checkbox" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="ReviewCheck" runat="server" Enabled='<%# Eval("IsEnabled") %>' />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="ReviewCheck2" runat="server" Enabled="false" />
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:Button ID="ReviewBtn" runat="server" Text="Reviewed" />
    <asp:Label ID="errorlbl" runat="server" Text=""></asp:Label>
    <asp:SqlDataSource ID="EntitySql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" 
        SelectCommand="ICAF_EntityTypes" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="FPINewSQL" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" 
        OldValuesParameterFormatString="original_{0}" ConflictDetection="OverwriteChanges"
        SelectCommand="SELECT *, CASE ISNULL(LeadClient,'') when '' then 1 else 0 end as IsEnabled FROM [ML_Data].[dbo].[NewFpi] (@user)" SelectCommandType="Text"
        UpdateCommand="FPI_Update" UpdateCommandType="StoredProcedure">
    <UpdateParameters>
        <asp:Parameter Name="clienttype" Type="String" />
        <asp:Parameter Name="Fpi_size" Type="String" />
        <asp:Parameter Name="fpisalutation" Type="String" />
        <asp:Parameter Name="fpiaddressee" Type="String" />
        <asp:Parameter Name="IsLead" Type="Boolean" />
        <asp:Parameter Name="leadClient" Type="String" />
        <asp:ControlParameter Name="user" ControlID="userlbl" PropertyName="Text" Type="String" />
        <asp:Parameter Name="original_CRMCLientID" Type="String" />
    </UpdateParameters>
    <SelectParameters>
	    <asp:ControlParameter Name="user" ControlID="ManagerDDL" PropertyName="SelectedValue" Type="String" />
    </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="LeadsSql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" 
        SelectCommand="Select clientcode + ' - ' + name as client, CRMClientID from FPINewView where isLead=1" SelectCommandType="Text">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="ReviewedSQL" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" 
        UpdateCommand="FPI_CreateDetail" UpdateCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="ManagerSql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" SelectCommand="ICAF_Managers" SelectCommandType="StoredProcedure"
        ProviderName="System.Data.SqlClient">
    </asp:SqlDataSource>

    <br />
    <asp:Label ID="UserLbl" runat="server" Text="" Visible="false"></asp:Label>
    
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
New FPI Clients
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
New FPI Clients
</asp:Content>
