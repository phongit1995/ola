.class Lchat/ola/vn/network/OlaNetworkService$10;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/activity/OlaFacebookActivity$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Ljava/lang/String;SS)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:S

.field final synthetic d:S

.field final synthetic e:Lchat/ola/vn/network/OlaNetworkService;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;Ljava/lang/String;SS)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/OlaNetworkService$10;->e:Lchat/ola/vn/network/OlaNetworkService;

    iput-object p2, p0, Lchat/ola/vn/network/OlaNetworkService$10;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/OlaNetworkService$10;->b:Ljava/lang/String;

    iput-short p4, p0, Lchat/ola/vn/network/OlaNetworkService$10;->c:S

    iput-short p5, p0, Lchat/ola/vn/network/OlaNetworkService$10;->d:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService$10;->e:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService$10;->a:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/network/OlaNetworkService$10;->b:Ljava/lang/String;

    iget-short v3, p0, Lchat/ola/vn/network/OlaNetworkService$10;->c:S

    iget-short v4, p0, Lchat/ola/vn/network/OlaNetworkService$10;->d:S

    invoke-static {v0, v1, v2, v3, v4}, Lchat/ola/vn/network/OlaNetworkService;->b(Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;Ljava/lang/String;SS)V

    return-void
.end method

.method public b()V
    .locals 0

    return-void
.end method
