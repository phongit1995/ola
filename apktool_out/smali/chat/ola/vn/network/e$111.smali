.class Lchat/ola/vn/network/e$111;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:[Ljava/lang/String;

.field final synthetic d:S

.field final synthetic e:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$111;->e:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$111;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/e$111;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/network/e$111;->c:[Ljava/lang/String;

    iput-short p5, p0, Lchat/ola/vn/network/e$111;->d:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/e$111;->e:Lchat/ola/vn/network/e;

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

    iget-object v2, p0, Lchat/ola/vn/network/e$111;->a:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/network/e$111;->b:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/network/e$111;->c:[Ljava/lang/String;

    iget-short v5, p0, Lchat/ola/vn/network/e$111;->d:S

    invoke-interface {v1, v2, v3, v4, v5}, Lchat/ola/vn/network/f;->c(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/e$111;->a:Ljava/lang/String;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/network/e$111;->a:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    :cond_1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v0, p0, Lchat/ola/vn/network/e$111;->c:[Ljava/lang/String;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/network/e$111;->c:[Ljava/lang/String;

    array-length v0, v0

    if-lez v0, :cond_3

    new-instance v0, Ljava/util/ArrayList;

    iget-object v2, p0, Lchat/ola/vn/network/e$111;->c:[Ljava/lang/String;

    array-length v2, v2

    invoke-direct {v0, v2}, Ljava/util/ArrayList;-><init>(I)V

    iget-object v2, p0, Lchat/ola/vn/network/e$111;->c:[Ljava/lang/String;

    array-length v3, v2

    const/4 v4, 0x0

    :goto_1
    if-ge v4, v3, :cond_2

    aget-object v5, v2, v4

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "#"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_2
    sget-object v2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v2, v0}, Lchat/ola/vn/r/a/e;->d(Ljava/util/List;)V

    :cond_3
    iget-short v0, p0, Lchat/ola/vn/network/e$111;->d:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_4

    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p0, Lchat/ola/vn/network/e$111;->a:Ljava/lang/String;

    aput-object v3, v2, v1

    iget-object v1, p0, Lchat/ola/vn/network/e$111;->b:Ljava/lang/String;

    const/4 v3, 0x1

    aput-object v1, v2, v3

    const/4 v1, 0x2

    iget-object v3, p0, Lchat/ola/vn/network/e$111;->c:[Ljava/lang/String;

    aput-object v3, v2, v1

    invoke-virtual {v0, v2}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void
.end method
