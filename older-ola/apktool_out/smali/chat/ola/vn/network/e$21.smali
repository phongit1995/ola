.class Lchat/ola/vn/network/e$21;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a([Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:[Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:[Ljava/lang/String;

.field final synthetic e:S

.field final synthetic f:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$21;->f:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$21;->a:[Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/e$21;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/network/e$21;->c:Ljava/lang/String;

    iput-object p5, p0, Lchat/ola/vn/network/e$21;->d:[Ljava/lang/String;

    iput-short p6, p0, Lchat/ola/vn/network/e$21;->e:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/e$21;->a:[Ljava/lang/String;

    const/4 v1, 0x0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/network/e$21;->a:[Ljava/lang/String;

    array-length v0, v0

    if-lez v0, :cond_3

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->y()Ljava/util/List;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/network/e$21;->b:Ljava/lang/String;

    if-nez v2, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    iget-object v2, p0, Lchat/ola/vn/network/e$21;->a:[Ljava/lang/String;

    array-length v2, v2

    invoke-direct {v0, v2}, Ljava/util/ArrayList;-><init>(I)V

    sput v1, Lchat/ola/vn/r/a/e;->b:I

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/network/e$21;->c:Ljava/lang/String;

    sput-object v2, Lchat/ola/vn/r/a/e;->a:Ljava/lang/String;

    const/4 v2, 0x0

    :goto_0
    iget-object v3, p0, Lchat/ola/vn/network/e$21;->a:[Ljava/lang/String;

    array-length v3, v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    if-ge v2, v3, :cond_2

    :try_start_1
    iget-object v3, p0, Lchat/ola/vn/network/e$21;->a:[Ljava/lang/String;

    aget-object v3, v3, v2

    const-string v4, "#"

    invoke-virtual {v3, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    sget-object v3, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v4, p0, Lchat/ola/vn/network/e$21;->a:[Ljava/lang/String;

    aget-object v4, v4, v2

    invoke-virtual {v3, v4, v1}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v3

    if-eqz v3, :cond_1

    goto :goto_1

    :cond_1
    new-instance v3, Lchat/ola/vn/message/f;

    iget-object v4, p0, Lchat/ola/vn/network/e$21;->a:[Ljava/lang/String;

    aget-object v4, v4, v2

    invoke-direct {v3, v4, v1}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :try_start_2
    iget-object v4, p0, Lchat/ola/vn/network/e$21;->d:[Ljava/lang/String;

    aget-object v4, v4, v2

    invoke-virtual {v3, v4}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    :try_start_3
    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    :try_start_4
    sget-object v2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v2, v0}, Lchat/ola/vn/message/g;->h(Ljava/util/List;)V

    :cond_3
    iget-short v0, p0, Lchat/ola/vn/network/e$21;->e:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_4

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p0, Lchat/ola/vn/network/e$21;->a:[Ljava/lang/String;

    aput-object v3, v2, v1

    iget-object v1, p0, Lchat/ola/vn/network/e$21;->c:Ljava/lang/String;

    const/4 v3, 0x1

    aput-object v1, v2, v3

    invoke-virtual {v0, v2}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :catch_2
    :cond_4
    return-void
.end method
