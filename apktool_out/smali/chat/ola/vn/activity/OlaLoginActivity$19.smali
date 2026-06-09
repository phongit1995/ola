.class Lchat/ola/vn/activity/OlaLoginActivity$19;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaLoginActivity;->a(Lchat/ola/vn/h/a;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/h/a;

.field final synthetic b:Lchat/ola/vn/activity/OlaLoginActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaLoginActivity;Lchat/ola/vn/h/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->b:Lchat/ola/vn/activity/OlaLoginActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->a:Lchat/ola/vn/h/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 4

    if-nez p2, :cond_3

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->b:Lchat/ola/vn/activity/OlaLoginActivity;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->a:Lchat/ola/vn/h/a;

    iget-object v0, v0, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v0, v0, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {p2, v0}, Lchat/ola/vn/h/b;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->b:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaLoginActivity;->c(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;

    move-result-object p2

    invoke-virtual {p2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->a:Lchat/ola/vn/h/a;

    iget-object v0, v0, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v0, v0, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {v0, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->b:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaLoginActivity;->c(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;

    move-result-object p2

    const-string v0, ""

    invoke-virtual {p2, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->b:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaLoginActivity;->d(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;

    move-result-object p2

    const-string v0, ""

    invoke-virtual {p2, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/e;->i()Ljava/lang/String;

    move-result-object p2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->a:Lchat/ola/vn/h/a;

    iget-object v0, v0, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v0, v0, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {v0, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p2

    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Lchat/ola/vn/e;->a(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_1
    :try_start_2
    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->b:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaLoginActivity;->i(Lchat/ola/vn/activity/OlaLoginActivity;)Ljava/util/List;

    move-result-object p2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->a:Lchat/ola/vn/h/a;

    invoke-interface {p2, v0}, Ljava/util/List;->remove(Ljava/lang/Object;)Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :try_start_3
    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->b:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaLoginActivity;->i(Lchat/ola/vn/activity/OlaLoginActivity;)Ljava/util/List;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p2

    const/16 v0, 0x8

    const/4 v1, 0x0

    if-lez p2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->b:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaLoginActivity;->i(Lchat/ola/vn/activity/OlaLoginActivity;)Ljava/util/List;

    move-result-object p2

    invoke-interface {p2, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/h/a;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->b:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaLoginActivity;->c(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;

    move-result-object v2

    iget-object v3, p2, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v3, v3, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->b:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaLoginActivity;->d(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;

    move-result-object v2

    iget-object p2, p2, Lchat/ola/vn/h/a;->b:Ljava/lang/String;

    invoke-virtual {v2, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->b:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaLoginActivity;->j(Lchat/ola/vn/activity/OlaLoginActivity;)Lchat/ola/vn/view/OlaGalleryView;

    move-result-object p2

    invoke-virtual {p2, v1}, Lchat/ola/vn/view/OlaGalleryView;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->b:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaLoginActivity;->k(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, v0}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->b:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaLoginActivity;->j(Lchat/ola/vn/activity/OlaLoginActivity;)Lchat/ola/vn/view/OlaGalleryView;

    move-result-object p2

    invoke-virtual {p2, v0}, Lchat/ola/vn/view/OlaGalleryView;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->b:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaLoginActivity;->k(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :goto_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$19;->b:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaLoginActivity;->l(Lchat/ola/vn/activity/OlaLoginActivity;)Lchat/ola/vn/b/t;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/b/t;->notifyDataSetChanged()V

    :cond_3
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
