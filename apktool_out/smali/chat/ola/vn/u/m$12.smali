.class Lchat/ola/vn/u/m$12;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/u/m;->c(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/u/m;


# direct methods
.method constructor <init>(Lchat/ola/vn/u/m;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/u/m$12;->b:Lchat/ola/vn/u/m;

    iput-object p2, p0, Lchat/ola/vn/u/m$12;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/u/m$12;->b:Lchat/ola/vn/u/m;

    iget-object v0, v0, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {v0}, Lchat/ola/vn/u/p;->c()Lchat/ola/vn/u/o;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/u/m$12;->b:Lchat/ola/vn/u/m;

    iget-object v1, v1, Lchat/ola/vn/u/m;->e:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/u/m$12;->a:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Lchat/ola/vn/u/o;->b(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
