.class Lchat/ola/vn/signup/OlaSignUpBySmsActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/j;


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

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$3;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Z)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$3;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->f(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)I

    const/4 v0, 0x0

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$3;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p2}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->d(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/EditText;

    move-result-object p2

    invoke-virtual {p2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$3;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-virtual {p2, v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->c(Z)V

    iget-object p2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$3;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p2}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->d(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Landroid/widget/EditText;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$3;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p1}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->g(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)I

    move-result p1

    iget-object p2, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$3;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-static {p2}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->h(Lchat/ola/vn/signup/OlaSignUpBySmsActivity;)Ljava/util/List;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p2

    if-lt p1, p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/signup/OlaSignUpBySmsActivity$3;->a:Lchat/ola/vn/signup/OlaSignUpBySmsActivity;

    invoke-virtual {p1, v0}, Lchat/ola/vn/signup/OlaSignUpBySmsActivity;->c(Z)V

    :cond_1
    return-void
.end method
