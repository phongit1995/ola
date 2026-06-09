.class Lchat/ola/vn/network/OlaNetworkService$2$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/OlaNetworkService$2;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/network/OlaNetworkService$2;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/OlaNetworkService$2;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/OlaNetworkService$2$1;->a:Lchat/ola/vn/network/OlaNetworkService$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p2

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$2$1;->a:Lchat/ola/vn/network/OlaNetworkService$2;

    iget-wide v0, v0, Lchat/ola/vn/network/OlaNetworkService$2;->a:J

    iget-object v2, p0, Lchat/ola/vn/network/OlaNetworkService$2$1;->a:Lchat/ola/vn/network/OlaNetworkService$2;

    iget-object v2, v2, Lchat/ola/vn/network/OlaNetworkService$2;->b:Ljava/lang/String;

    invoke-static {p2, v0, v1, v2}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;JLjava/lang/String;)V

    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
