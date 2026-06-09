.class Lchat/ola/vn/network/e$71;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Ljava/lang/String;Ljava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:S

.field final synthetic d:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$71;->d:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$71;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/e$71;->b:Ljava/lang/String;

    iput-short p4, p0, Lchat/ola/vn/network/e$71;->c:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/e$71;->d:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    iget-object v2, p0, Lchat/ola/vn/network/e$71;->a:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/network/e$71;->b:Ljava/lang/String;

    iget-short v4, p0, Lchat/ola/vn/network/e$71;->c:S

    invoke-interface {v1, v2, v3, v4}, Lchat/ola/vn/network/f;->a(Ljava/lang/String;Ljava/lang/String;S)V

    goto :goto_0

    :cond_0
    iget-short v0, p0, Lchat/ola/vn/network/e$71;->c:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_1

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
