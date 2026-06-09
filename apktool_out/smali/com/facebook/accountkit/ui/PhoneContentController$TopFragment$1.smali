.class Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/ui/AccountKitSpinner$OnSpinnerEventsListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->onViewReadyWithState(Landroid/view/View;Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

.field final synthetic val$activity:Landroid/app/Activity;

.field final synthetic val$countryCodeView:Lcom/facebook/accountkit/ui/AccountKitSpinner;

.field final synthetic val$phoneNumberView:Landroid/widget/EditText;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;Lcom/facebook/accountkit/ui/AccountKitSpinner;Landroid/app/Activity;Landroid/widget/EditText;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;->val$countryCodeView:Lcom/facebook/accountkit/ui/AccountKitSpinner;

    iput-object p3, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;->val$activity:Landroid/app/Activity;

    iput-object p4, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;->val$phoneNumberView:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSpinnerClosed()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;->val$countryCodeView:Lcom/facebook/accountkit/ui/AccountKitSpinner;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitSpinner;->getSelectedItem()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;->countryCode:Ljava/lang/String;

    const/4 v1, 0x0

    invoke-static {v1, v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUICountryCode(ZLjava/lang/String;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->setLastPhoneNumber(Lcom/facebook/accountkit/PhoneNumber;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;->val$countryCodeView:Lcom/facebook/accountkit/ui/AccountKitSpinner;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitSpinner;->getSelectedItem()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;->countryCode:Ljava/lang/String;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;->val$phoneNumberView:Landroid/widget/EditText;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->access$300(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;->val$phoneNumberView:Landroid/widget/EditText;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;->val$phoneNumberView:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSelection(I)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;->val$phoneNumberView:Landroid/widget/EditText;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/ViewUtility;->showKeyboard(Landroid/view/View;)V

    return-void
.end method

.method public onSpinnerOpened()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;->val$countryCodeView:Lcom/facebook/accountkit/ui/AccountKitSpinner;

    invoke-virtual {v0}, Lcom/facebook/accountkit/ui/AccountKitSpinner;->getSelectedItem()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;

    iget-object v0, v0, Lcom/facebook/accountkit/ui/PhoneCountryCodeAdapter$ValueData;->countryCode:Ljava/lang/String;

    const/4 v1, 0x1

    invoke-static {v1, v0}, Lcom/facebook/accountkit/internal/AccountKitController$Logger;->logUICountryCode(ZLjava/lang/String;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$1;->val$activity:Landroid/app/Activity;

    invoke-static {v0}, Lcom/facebook/accountkit/ui/ViewUtility;->hideKeyboard(Landroid/app/Activity;)V

    return-void
.end method
