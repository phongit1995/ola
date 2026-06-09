.class final Lchat/ola/vn/util/b$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/b;->a(Landroid/content/Context;Landroid/net/Uri;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;

.field final synthetic b:Landroid/net/Uri;


# direct methods
.method constructor <init>(Landroid/content/Context;Landroid/net/Uri;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/b$1;->a:Landroid/content/Context;

    iput-object p2, p0, Lchat/ola/vn/util/b$1;->b:Landroid/net/Uri;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    :try_start_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    if-nez p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/util/b$1;->a:Landroid/content/Context;

    invoke-static {p1}, Lchat/ola/vn/util/b;->b(Landroid/content/Context;)V

    return-void

    :cond_0
    new-instance p1, Landroid/content/Intent;

    invoke-direct {p1}, Landroid/content/Intent;-><init>()V

    const-string p2, "android.intent.action.VIEW"

    invoke-virtual {p1, p2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    iget-object p2, p0, Lchat/ola/vn/util/b$1;->b:Landroid/net/Uri;

    const-string v0, "video/*"

    invoke-virtual {p1, p2, v0}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    iget-object p2, p0, Lchat/ola/vn/util/b$1;->a:Landroid/content/Context;

    invoke-virtual {p2, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
