.class Lchat/ola/vn/activity/OlaOAuthenLoginActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaOAuthenLoginActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaOAuthenLoginActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$2;->a:Lchat/ola/vn/activity/OlaOAuthenLoginActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$2;->a:Lchat/ola/vn/activity/OlaOAuthenLoginActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->b(Lchat/ola/vn/activity/OlaOAuthenLoginActivity;)Landroid/app/Dialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$2;->a:Lchat/ola/vn/activity/OlaOAuthenLoginActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->a(Lchat/ola/vn/activity/OlaOAuthenLoginActivity;Landroid/app/Dialog;)Landroid/app/Dialog;

    return-void
.end method
