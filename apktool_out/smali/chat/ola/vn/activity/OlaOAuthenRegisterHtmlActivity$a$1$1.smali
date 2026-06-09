.class Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1$1;->a:Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    if-nez p2, :cond_0

    new-instance p2, Landroid/content/Intent;

    invoke-direct {p2}, Landroid/content/Intent;-><init>()V

    const-string v0, "_username"

    iget-object v1, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1$1;->a:Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;->a:Ljava/lang/String;

    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v0, "_pass"

    iget-object v1, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1$1;->a:Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;->b:Ljava/lang/String;

    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1$1;->a:Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;->c:Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a;->a:Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;

    const/4 v1, -0x1

    invoke-virtual {v0, v1, p2}, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->setResult(ILandroid/content/Intent;)V

    :cond_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1$1;->a:Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;->c:Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a;->a:Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;->finish()V

    return-void
.end method
