.class Lchat/ola/vn/network/e$16;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->b(Ljava/lang/String;Ljava/lang/String;[Lchat/ola/vn/entity/g;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:S

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:[Lchat/ola/vn/entity/g;

.field final synthetic e:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;SLjava/lang/String;Ljava/lang/String;[Lchat/ola/vn/entity/g;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$16;->e:Lchat/ola/vn/network/e;

    iput-short p2, p0, Lchat/ola/vn/network/e$16;->a:S

    iput-object p3, p0, Lchat/ola/vn/network/e$16;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/network/e$16;->c:Ljava/lang/String;

    iput-object p5, p0, Lchat/ola/vn/network/e$16;->d:[Lchat/ola/vn/entity/g;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    :try_start_0
    iget-short v0, p0, Lchat/ola/vn/network/e$16;->a:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v1, p0, Lchat/ola/vn/network/e$16;->b:Ljava/lang/String;

    if-nez v1, :cond_0

    const-string v1, ""

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/network/e$16;->c:Ljava/lang/String;

    if-nez v2, :cond_1

    const-string v2, ""

    :cond_1
    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object v1, v3, v4

    const/4 v1, 0x1

    aput-object v2, v3, v1

    const/4 v1, 0x2

    iget-object v2, p0, Lchat/ola/vn/network/e$16;->d:[Lchat/ola/vn/entity/g;

    aput-object v2, v3, v1

    invoke-virtual {v0, v3}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method
