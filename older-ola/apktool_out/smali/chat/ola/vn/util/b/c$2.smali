.class Lchat/ola/vn/util/b/c$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/b/c;->a(Lchat/ola/vn/entity/i;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/util/b/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/util/b/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/b/c$2;->a:Lchat/ola/vn/util/b/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/b/c$2;->a:Lchat/ola/vn/util/b/c;

    const/4 v1, 0x1

    iput-short v1, v0, Lchat/ola/vn/util/b/c;->a:S

    iget-object v0, p0, Lchat/ola/vn/util/b/c$2;->a:Lchat/ola/vn/util/b/c;

    invoke-static {v0}, Lchat/ola/vn/util/b/c;->a(Lchat/ola/vn/util/b/c;)Lchat/ola/vn/util/b/a;

    move-result-object v0

    invoke-interface {v0}, Lchat/ola/vn/util/b/a;->b()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
