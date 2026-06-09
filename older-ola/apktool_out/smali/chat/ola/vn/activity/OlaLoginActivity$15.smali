.class Lchat/ola/vn/activity/OlaLoginActivity$15;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaLoginActivity;->F()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaLoginActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaLoginActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$15;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 3

    const v0, 0x7f0f0548

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity$15;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaLoginActivity;->c(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity$15;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaLoginActivity;->d(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;

    move-result-object v2

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity$15;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaLoginActivity;->f(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/Button;

    move-result-object v1

    const v2, 0x7f0f05dc

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setText(I)V

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity$15;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaLoginActivity;->f(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/Button;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/widget/Button;->setText(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity$15;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaLoginActivity;->f(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/Button;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/widget/Button;->setText(I)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$15;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaLoginActivity;->g(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/view/View;

    move-result-object v0

    invoke-interface {p1}, Landroid/text/Editable;->length()I

    move-result p1

    if-nez p1, :cond_1

    const/16 p1, 0x8

    goto :goto_1

    :cond_1
    const/4 p1, 0x0

    :goto_1
    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V

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
