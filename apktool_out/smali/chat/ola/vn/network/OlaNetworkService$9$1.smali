.class Lchat/ola/vn/network/OlaNetworkService$9$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/OlaNetworkService$9;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/network/OlaNetworkService$9;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/OlaNetworkService$9;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/OlaNetworkService$9$1;->a:Lchat/ola/vn/network/OlaNetworkService$9;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$9$1;->a:Lchat/ola/vn/network/OlaNetworkService$9;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService$9;->e:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService$9$1;->a:Lchat/ola/vn/network/OlaNetworkService$9;

    iget-object v1, v1, Lchat/ola/vn/network/OlaNetworkService$9;->a:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/network/OlaNetworkService$9$1;->a:Lchat/ola/vn/network/OlaNetworkService$9;

    iget-object v2, v2, Lchat/ola/vn/network/OlaNetworkService$9;->b:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService$9$1;->a:Lchat/ola/vn/network/OlaNetworkService$9;

    iget-short v3, v3, Lchat/ola/vn/network/OlaNetworkService$9;->c:S

    iget-object v4, p0, Lchat/ola/vn/network/OlaNetworkService$9$1;->a:Lchat/ola/vn/network/OlaNetworkService$9;

    iget-short v4, v4, Lchat/ola/vn/network/OlaNetworkService$9;->d:S

    invoke-static {v0, v1, v2, v3, v4}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;Ljava/lang/String;SS)V

    return-void
.end method
