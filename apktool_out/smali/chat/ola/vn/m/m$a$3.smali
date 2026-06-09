.class Lchat/ola/vn/m/m$a$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/m$a;->onCloseApp()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/m$a;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/m$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/m$a$3;->a:Lchat/ola/vn/m/m$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/m$a$3;->a:Lchat/ola/vn/m/m$a;

    iget-object v0, v0, Lchat/ola/vn/m/m$a;->a:Lchat/ola/vn/m/m;

    invoke-static {v0}, Lchat/ola/vn/m/m;->b(Lchat/ola/vn/m/m;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    iget-object v1, p0, Lchat/ola/vn/m/m$a$3;->a:Lchat/ola/vn/m/m$a;

    iget-object v1, v1, Lchat/ola/vn/m/m$a;->a:Lchat/ola/vn/m/m;

    invoke-virtual {v1}, Lchat/ola/vn/m/m;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "onCloseApp #"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method
