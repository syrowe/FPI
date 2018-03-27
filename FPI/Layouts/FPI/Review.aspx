<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="VB" AutoEventWireup="true" CodeBehind="Review.aspx.vb" Inherits="FPI.Layouts.FPI.Review" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
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
  <br />
    <asp:Label ID="Label1" runat="server" Text="Search: ">&nbsp</asp:Label><asp:TextBox ID="SearchTB" Width="200px" runat="server" AutoPostBack="true"></asp:TextBox><br /><asp:CheckBox ID="CheckBox1" Text="Search individual invoice lines " Checked="false" AutoPostBack="true" runat="server" /><br /><asp:CheckBox ID="CheckBox2" Text="Prior Year " Checked="false" AutoPostBack="true" runat="server" /> 
  <br />
  <Sharepoint:SPGridView ID="SPGrid" runat="server" DataSourceID="CCHSql" DataKeyNames="id, balance"
            EnableModelValidation="True" AutoGenerateColumns="False" AllowFiltering="true" FilterDataFields="MANAGER" EnableViewState="false" FooterStyle-Font-Bold="true"
            AllowPaging="True" PageSize="20" AllowSorting="True" AllowGrouping="false" UseAccessibleHeader="true" ShowFooter="false" Width="90%" BorderStyle="None" 
            CellPadding="1" CellSpacing="1" >
        <Columns>
            <asp:TemplateField HeaderText="Code" sortExpression="Clientcode">
                <ItemTemplate>
                    <asp:HyperLink ID="hyperDetails" runat="server" NavigateUrl='<%# "~/_Layouts/ML_Webparts/Client.aspx?Clientcode=" + HttpUtility.UrlDecode(Eval("clientcode").ToString())  %>' Text='<%# Eval("clientcode").ToString() %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="lead_name" HeaderText="Name" SortExpression="lead_name"/>				
			<asp:BoundField DataField="Manager" HeaderText="Manager" SortExpression="Manager" />
            <asp:BoundField DataField="Invoicelines" HeaderText="Invoice Detail" ItemStyle-Wrap="true" SortExpression="invoicelines" />
            <asp:BoundField DataField="totalPremium" HeaderText="Total Premium" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:f2}" FooterStyle-HorizontalAlign="Right" SortExpression="totalPremium" ItemStyle-HorizontalAlign="Right"  />
            <asp:BoundField DataField="Paid" HeaderText="Paid" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:f2}" FooterStyle-HorizontalAlign="Right" SortExpression="Paid" ItemStyle-HorizontalAlign="Right"  />
            <asp:BoundField DataField="Balance" HeaderText="Balance" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:f2}" FooterStyle-HorizontalAlign="Right" SortExpression="Balance" ItemStyle-HorizontalAlign="Right"  />
            <asp:TemplateField HeaderText="Notes">
                <ItemTemplate>
                    <a href="javascript:;" onclick="openDialog('AddNote.aspx' , '<%# Eval("id") %>' , 'Add Note');" ><%# Eval("notes").ToString()%></a> 
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <a href="javascript:;" onclick="openDialog('LogReceipt.aspx' , '<%# Eval("id") %>' , 'Log Receipt');">Log Reciept</a> 
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <a href="javascript:;" onclick="openDialog('ReCalc.aspx' , '<%# Eval("id") %>' , 'Re-Calculate');">Re-Calculate Fee</a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <a href="javascript:;" onclick="openDialog('Delete.aspx' , '<%# Eval("id") %>' , 'Re-Calculate');">Delete Invoice</a>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </Sharepoint:SPGridView>

  
    <!--SQL for billing data -->
    <asp:SqlDataSource ID="CCHSql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" 
        SelectCommand="FPI_Search" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="SearchTB" Name="SearchStr" Type="String" />
            <asp:ControlParameter ControlID="CheckBox1" Name="IncSubs" Type="Boolean" />
            <asp:ControlParameter ControlID="CheckBox2" Name="PriorYear" Type="Boolean" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Review
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Review
</asp:Content>
