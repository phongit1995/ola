.class Lchat/ola/vn/network/e$36;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->b(Ljava/util/List;Ljava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:S

.field final synthetic d:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/util/List;Ljava/lang/String;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$36;->d:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$36;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/network/e$36;->b:Ljava/lang/String;

    iput-short p4, p0, Lchat/ola/vn/network/e$36;->c:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/network/e$36;->a:Ljava/util/List;

    iget-object v2, p0, Lchat/ola/vn/network/e$36;->b:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->a(Ljava/util/List;Ljava/lang/String;)V

    iget-short v0, p0, Lchat/ola/vn/network/e$36;->c:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    iget-object v3, p0, Lchat/ola/vn/network/e$36;->a:Ljava/util/List;

    aput-object v3, v1, v2

    const/4 v2, 0x1

    iget-object v3, p0, Lchat/ola/vn/network/e$36;->b:Ljava/lang/String;

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
