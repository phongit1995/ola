.class Lchat/ola/vn/entity/m$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entity/m;->a([BLjava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/Object;

.field final synthetic b:Lchat/ola/vn/entity/m;


# direct methods
.method constructor <init>(Lchat/ola/vn/entity/m;Ljava/lang/Object;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/m$1;->b:Lchat/ola/vn/entity/m;

    iput-object p2, p0, Lchat/ola/vn/entity/m$1;->a:Ljava/lang/Object;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/entity/m$1;->b:Lchat/ola/vn/entity/m;

    iget-object v1, p0, Lchat/ola/vn/entity/m$1;->a:Ljava/lang/Object;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/m;->a(Ljava/lang/Object;)V

    return-void
.end method
