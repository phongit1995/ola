.class Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a;->onSignUpComplete(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;->c:Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;->b:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;->c:Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a;

    iget-object v1, v0, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a;->a:Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity;

    const v2, 0x7f0f00a2

    const v3, 0x7f0f05df

    const v4, 0x7f0f0480

    const/4 v5, 0x0

    new-instance v6, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1$1;

    invoke-direct {v6, p0}, Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1$1;-><init>(Lchat/ola/vn/activity/OlaOAuthenRegisterHtmlActivity$a$1;)V

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/Dialog;->setCancelable(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
