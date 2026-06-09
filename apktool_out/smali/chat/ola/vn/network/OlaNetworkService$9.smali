.class Lchat/ola/vn/network/OlaNetworkService$9;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/activity/OlaFacebookActivity$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SS)V
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

    iput-object p1, p0, Lchat/ola/vn/network/OlaNetworkService$9;->e:Lchat/ola/vn/network/OlaNetworkService;

    iput-object p2, p0, Lchat/ola/vn/network/OlaNetworkService$9;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/OlaNetworkService$9;->b:Ljava/lang/String;

    iput-short p4, p0, Lchat/ola/vn/network/OlaNetworkService$9;->c:S

    iput-short p5, p0, Lchat/ola/vn/network/OlaNetworkService$9;->d:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/OlaNetworkService$9$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/network/OlaNetworkService$9$1;-><init>(Lchat/ola/vn/network/OlaNetworkService$9;)V

    const-wide/16 v1, 0x3e8

    invoke-static {v0, v1, v2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void
.end method
