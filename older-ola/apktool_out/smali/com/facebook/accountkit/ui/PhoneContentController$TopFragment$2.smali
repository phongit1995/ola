.class Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$2;
.super Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;


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

.field final synthetic val$countryCodeView:Lcom/facebook/accountkit/ui/AccountKitSpinner;


# direct methods
.method constructor <init>(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;Ljava/lang/String;Lcom/facebook/accountkit/ui/AccountKitSpinner;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$2;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    iput-object p3, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$2;->val$countryCodeView:Lcom/facebook/accountkit/ui/AccountKitSpinner;

    invoke-direct {p0, p2}, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 4

    invoke-super {p0, p1}, Lcom/facebook/accountkit/ui/PhoneNumberTextWatcher;->afterTextChanged(Landroid/text/Editable;)V

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_3

    const-string v1, "+"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/facebook/accountkit/internal/Utility;->createI8nPhoneNumber(Ljava/lang/String;)Lcom/google/i18n/phonenumbers/Phonenumber$PhoneNumber;

    move-result-object p1

    iget-object v1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$2;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    if-eqz p1, :cond_1

    invoke-static {}, Lcom/google/i18n/phonenumbers/PhoneNumberUtil;->getInstance()Lcom/google/i18n/phonenumbers/PhoneNumberUtil;

    move-result-object v3

    invoke-virtual {v3, p1}, Lcom/google/i18n/phonenumbers/PhoneNumberUtil;->isValidNumber(Lcom/google/i18n/phonenumbers/Phonenumber$PhoneNumber;)Z

    move-result p1

    if-eqz p1, :cond_1

    const/4 v2, 0x1

    :cond_1
    invoke-static {v1, v2}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->access$402(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;Z)Z

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$2;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->access$500(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;)Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$OnPhoneNumberChangedListener;

    move-result-object p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$2;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    invoke-static {p1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->access$500(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;)Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$OnPhoneNumberChangedListener;

    move-result-object p1

    invoke-interface {p1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$OnPhoneNumberChangedListener;->onPhoneNumberChanged()V

    :cond_2
    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$2;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    iget-object v1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$2;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->getPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;

    move-result-object v1

    invoke-virtual {p1, v1}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->setLastPhoneNumber(Lcom/facebook/accountkit/PhoneNumber;)V

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$2;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    invoke-static {p1, v0}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->access$600(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;Ljava/lang/String;)V

    return-void

    :cond_3
    :goto_0
    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$2;->this$0:Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;

    invoke-static {p1, v2}, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;->access$402(Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment;Z)Z

    iget-object p1, p0, Lcom/facebook/accountkit/ui/PhoneContentController$TopFragment$2;->val$countryCodeView:Lcom/facebook/accountkit/ui/AccountKitSpinner;

    invoke-virtual {p1}, Lcom/facebook/accountkit/ui/AccountKitSpinner;->performClick()Z

    return-void
.end method
