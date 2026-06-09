.class Lchat/ola/vn/network/e$68;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a([Lchat/ola/vn/entity/j;IS)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:[Lchat/ola/vn/entity/j;

.field final synthetic b:I

.field final synthetic c:S

.field final synthetic d:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;[Lchat/ola/vn/entity/j;IS)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$68;->d:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$68;->a:[Lchat/ola/vn/entity/j;

    iput p3, p0, Lchat/ola/vn/network/e$68;->b:I

    iput-short p4, p0, Lchat/ola/vn/network/e$68;->c:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/c/b;->a(Landroid/content/Context;)V

    iget-object v0, p0, Lchat/ola/vn/network/e$68;->d:Lchat/ola/vn/network/e;

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

    iget-object v2, p0, Lchat/ola/vn/network/e$68;->a:[Lchat/ola/vn/entity/j;

    iget v3, p0, Lchat/ola/vn/network/e$68;->b:I

    iget-short v4, p0, Lchat/ola/vn/network/e$68;->c:S

    invoke-interface {v1, v2, v3, v4}, Lchat/ola/vn/network/f;->a([Lchat/ola/vn/entity/j;IS)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/e$68;->a:[Lchat/ola/vn/entity/j;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    :goto_1
    iget-object v2, p0, Lchat/ola/vn/network/e$68;->a:[Lchat/ola/vn/entity/j;

    array-length v2, v2

    if-ge v0, v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/network/e$68;->a:[Lchat/ola/vn/entity/j;

    aget-object v2, v2, v0

    iget-object v3, p0, Lchat/ola/vn/network/e$68;->a:[Lchat/ola/vn/entity/j;

    aget-object v3, v3, v0

    iget-object v3, v3, Lchat/ola/vn/entity/j;->e:Ljava/lang/String;

    const-string v4, ""

    invoke-static {v3, v4}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lchat/ola/vn/entity/j;->e:Ljava/lang/String;

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    iget-short v0, p0, Lchat/ola/vn/network/e$68;->c:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_2

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p0, Lchat/ola/vn/network/e$68;->a:[Lchat/ola/vn/entity/j;

    aput-object v3, v2, v1

    iget v1, p0, Lchat/ola/vn/network/e$68;->b:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v3, 0x1

    aput-object v1, v2, v3

    invoke-virtual {v0, v2}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method
