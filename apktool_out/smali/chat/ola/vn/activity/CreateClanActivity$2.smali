.class Lchat/ola/vn/activity/CreateClanActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/CreateClanActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/CreateClanActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/CreateClanActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$2;->a:Lchat/ola/vn/activity/CreateClanActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 0

    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 3

    iget-object p2, p0, Lchat/ola/vn/activity/CreateClanActivity$2;->a:Lchat/ola/vn/activity/CreateClanActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/CreateClanActivity;->b(Lchat/ola/vn/activity/CreateClanActivity;)Ljava/lang/String;

    move-result-object p2

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    const/16 p2, 0x8

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$2;->a:Lchat/ola/vn/activity/CreateClanActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/CreateClanActivity;->b(Lchat/ola/vn/activity/CreateClanActivity;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$2;->a:Lchat/ola/vn/activity/CreateClanActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/CreateClanActivity;->c(Lchat/ola/vn/activity/CreateClanActivity;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$2;->a:Lchat/ola/vn/activity/CreateClanActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/CreateClanActivity;->d(Lchat/ola/vn/activity/CreateClanActivity;)Lchat/ola/vn/activity/CreateClanActivity$a;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/CreateClanActivity$a;->a(Lchat/ola/vn/activity/CreateClanActivity$a;)V

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$2;->a:Lchat/ola/vn/activity/CreateClanActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/CreateClanActivity;->e(Lchat/ola/vn/activity/CreateClanActivity;)Landroid/widget/TextView;

    move-result-object p1

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$2;->a:Lchat/ola/vn/activity/CreateClanActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/CreateClanActivity;->e(Lchat/ola/vn/activity/CreateClanActivity;)Landroid/widget/TextView;

    move-result-object p1

    iget-object p3, p0, Lchat/ola/vn/activity/CreateClanActivity$2;->a:Lchat/ola/vn/activity/CreateClanActivity;

    const p4, 0x7f0f01de

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "#"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/activity/CreateClanActivity$2;->a:Lchat/ola/vn/activity/CreateClanActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/CreateClanActivity;->b(Lchat/ola/vn/activity/CreateClanActivity;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v0, p2

    invoke-virtual {p3, p4, v0}, Lchat/ola/vn/activity/CreateClanActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$2;->a:Lchat/ola/vn/activity/CreateClanActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/CreateClanActivity;->d(Lchat/ola/vn/activity/CreateClanActivity;)Lchat/ola/vn/activity/CreateClanActivity$a;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/CreateClanActivity$a;->b(Lchat/ola/vn/activity/CreateClanActivity$a;)V

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$2;->a:Lchat/ola/vn/activity/CreateClanActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/CreateClanActivity;->c(Lchat/ola/vn/activity/CreateClanActivity;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/CreateClanActivity$2;->a:Lchat/ola/vn/activity/CreateClanActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/CreateClanActivity;->e(Lchat/ola/vn/activity/CreateClanActivity;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_1
    return-void
.end method
