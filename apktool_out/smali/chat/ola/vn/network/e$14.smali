.class Lchat/ola/vn/network/e$14;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->c(Lchat/ola/vn/entity/ad;Ljava/util/List;Ljava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:S

.field final synthetic b:Lchat/ola/vn/entity/ad;

.field final synthetic c:Ljava/util/List;

.field final synthetic d:Ljava/lang/String;

.field final synthetic e:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;SLchat/ola/vn/entity/ad;Ljava/util/List;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$14;->e:Lchat/ola/vn/network/e;

    iput-short p2, p0, Lchat/ola/vn/network/e$14;->a:S

    iput-object p3, p0, Lchat/ola/vn/network/e$14;->b:Lchat/ola/vn/entity/ad;

    iput-object p4, p0, Lchat/ola/vn/network/e$14;->c:Ljava/util/List;

    iput-object p5, p0, Lchat/ola/vn/network/e$14;->d:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    iget-short v0, p0, Lchat/ola/vn/network/e$14;->a:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v1, 0x3

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    iget-object v3, p0, Lchat/ola/vn/network/e$14;->b:Lchat/ola/vn/entity/ad;

    aput-object v3, v1, v2

    const/4 v2, 0x1

    iget-object v3, p0, Lchat/ola/vn/network/e$14;->c:Ljava/util/List;

    aput-object v3, v1, v2

    const/4 v2, 0x2

    iget-object v3, p0, Lchat/ola/vn/network/e$14;->d:Ljava/lang/String;

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
