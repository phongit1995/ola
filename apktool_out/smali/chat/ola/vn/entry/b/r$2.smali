.class Lchat/ola/vn/entry/b/r$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/network/a/a/aj$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/r;->a(Lchat/ola/vn/message/i;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/r;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/r;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/r$2;->a:Lchat/ola/vn/entry/b/r;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/z;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/r$2;->a:Lchat/ola/vn/entry/b/r;

    iget-object v0, v0, Lchat/ola/vn/entry/b/r;->D:Lchat/ola/vn/message/i;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/i;->a(Lchat/ola/vn/entity/z;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/r$2;->a:Lchat/ola/vn/entry/b/r;

    invoke-static {p1}, Lchat/ola/vn/entry/b/r;->c(Lchat/ola/vn/entry/b/r;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    new-instance v0, Lchat/ola/vn/entity/z;

    invoke-direct {v0}, Lchat/ola/vn/entity/z;-><init>()V

    iput-object p1, v0, Lchat/ola/vn/entity/z;->b:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/entry/b/r$2;->a:Lchat/ola/vn/entry/b/r;

    iget-object p1, p1, Lchat/ola/vn/entry/b/r;->D:Lchat/ola/vn/message/i;

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/i;->a(Lchat/ola/vn/entity/z;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
