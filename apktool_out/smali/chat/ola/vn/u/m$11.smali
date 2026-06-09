.class Lchat/ola/vn/u/m$11;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/u/m;->a(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/u/o;

.field final synthetic b:Lchat/ola/vn/entity/i;

.field final synthetic c:Lchat/ola/vn/u/m;


# direct methods
.method constructor <init>(Lchat/ola/vn/u/m;Lchat/ola/vn/u/o;Lchat/ola/vn/entity/i;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/u/m$11;->c:Lchat/ola/vn/u/m;

    iput-object p2, p0, Lchat/ola/vn/u/m$11;->a:Lchat/ola/vn/u/o;

    iput-object p3, p0, Lchat/ola/vn/u/m$11;->b:Lchat/ola/vn/entity/i;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/u/m$11;->a:Lchat/ola/vn/u/o;

    iget-object v1, p0, Lchat/ola/vn/u/m$11;->b:Lchat/ola/vn/entity/i;

    invoke-interface {v0, v1}, Lchat/ola/vn/u/o;->a(Lchat/ola/vn/entity/i;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
