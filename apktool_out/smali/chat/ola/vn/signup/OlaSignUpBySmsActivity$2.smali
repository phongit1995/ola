.class Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->b(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/TextView;

    move-result-object p1

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->c(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Ljava/lang/Runnable;

    move-result-object p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    new-instance v0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2$1;-><init>(Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;)V

    invoke-static {p1, v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->a(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;Ljava/lang/Runnable;)Ljava/lang/Runnable;

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->c(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Ljava/lang/Runnable;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$2;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->c(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Ljava/lang/Runnable;

    move-result-object p1

    const-wide/16 v0, 0x3e8

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method
