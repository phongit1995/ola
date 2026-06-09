.class Lchat/ola/vn/signup/c$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/j;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/c;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/c$2;->a:Lchat/ola/vn/signup/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Z)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/signup/c$2;->a:Lchat/ola/vn/signup/c;

    invoke-static {v0}, Lchat/ola/vn/signup/c;->e(Lchat/ola/vn/signup/c;)I

    const/4 v0, 0x0

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/signup/c$2;->a:Lchat/ola/vn/signup/c;

    invoke-static {p2}, Lchat/ola/vn/signup/c;->c(Lchat/ola/vn/signup/c;)Landroid/widget/EditText;

    move-result-object p2

    invoke-virtual {p2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/signup/c$2;->a:Lchat/ola/vn/signup/c;

    invoke-virtual {p2}, Lchat/ola/vn/signup/c;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object p2

    invoke-virtual {p2, v0}, Lchat/ola/vn/signup/OlaSignUpActivity;->c(Z)V

    iget-object p2, p0, Lchat/ola/vn/signup/c$2;->a:Lchat/ola/vn/signup/c;

    invoke-static {p2}, Lchat/ola/vn/signup/c;->c(Lchat/ola/vn/signup/c;)Landroid/widget/EditText;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/signup/c$2;->a:Lchat/ola/vn/signup/c;

    invoke-static {p1}, Lchat/ola/vn/signup/c;->f(Lchat/ola/vn/signup/c;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/signup/c$2;->a:Lchat/ola/vn/signup/c;

    invoke-static {p1}, Lchat/ola/vn/signup/c;->g(Lchat/ola/vn/signup/c;)I

    move-result p1

    iget-object p2, p0, Lchat/ola/vn/signup/c$2;->a:Lchat/ola/vn/signup/c;

    invoke-static {p2}, Lchat/ola/vn/signup/c;->h(Lchat/ola/vn/signup/c;)Ljava/util/List;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p2

    if-lt p1, p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/signup/c$2;->a:Lchat/ola/vn/signup/c;

    invoke-virtual {p1}, Lchat/ola/vn/signup/c;->j()Lchat/ola/vn/signup/OlaSignUpActivity;

    move-result-object p1

    invoke-virtual {p1, v0}, Lchat/ola/vn/signup/OlaSignUpActivity;->c(Z)V

    :cond_1
    return-void
.end method
