.class Lchat/ola/vn/activity/OlaLoginActivity$6;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaLoginActivity;->f(Ljava/lang/String;)V
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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$6;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 6

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$6;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$6;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    const v1, 0x7f0f00a0

    invoke-virtual {p2, v1}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$6;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    const v2, 0x7f0f036d

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    const-string v5, "1900588883"

    aput-object v5, v3, v4

    invoke-virtual {p2, v2, v3}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$6;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    const v3, 0x7f0f0480

    invoke-virtual {p2, v3}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    new-instance v5, Lchat/ola/vn/activity/OlaLoginActivity$6$1;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaLoginActivity$6$1;-><init>(Lchat/ola/vn/activity/OlaLoginActivity$6;)V

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/e;

    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
