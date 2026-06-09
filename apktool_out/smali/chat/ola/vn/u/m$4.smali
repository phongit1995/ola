.class Lchat/ola/vn/u/m$4;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/u/m;->a(Ljava/lang/String;ILjava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/u/m;


# direct methods
.method constructor <init>(Lchat/ola/vn/u/m;ILjava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/u/m$4;->c:Lchat/ola/vn/u/m;

    iput p2, p0, Lchat/ola/vn/u/m$4;->a:I

    iput-object p3, p0, Lchat/ola/vn/u/m$4;->b:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/u/m$4;->c:Lchat/ola/vn/u/m;

    iget-object v0, v0, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {v0}, Lchat/ola/vn/u/p;->c()Lchat/ola/vn/u/o;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/u/m$4;->c:Lchat/ola/vn/u/m;

    iget-object v1, v1, Lchat/ola/vn/u/m;->e:Ljava/lang/String;

    iget v2, p0, Lchat/ola/vn/u/m$4;->a:I

    iget-object v3, p0, Lchat/ola/vn/u/m$4;->b:Ljava/lang/String;

    invoke-interface {v0, v1, v2, v3}, Lchat/ola/vn/u/o;->a(Ljava/lang/String;ILjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
