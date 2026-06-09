.class public Lchat/ola/vn/entry/c/b;
.super Lchat/ola/vn/entry/c/e;


# instance fields
.field private a:J


# direct methods
.method public constructor <init>(J)V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/entry/c/b;->a:J

    iput-wide p1, p0, Lchat/ola/vn/entry/c/b;->a:J

    return-void
.end method

.method private a(Ljava/lang/String;SLjava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "S",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;)V"
        }
    .end annotation

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/r/a/e;->a(Ljava/lang/String;SLjava/util/List;)V

    return-void
.end method

.method private a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;)V"
        }
    .end annotation

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0, p1}, Lchat/ola/vn/r/a/e;->c(Ljava/util/List;)V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x41

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 6

    sget-object p2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    const/16 p3, 0x22

    if-ne p1, p3, :cond_1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-wide p3, p0, Lchat/ola/vn/entry/c/b;->a:J

    const-wide/16 v0, 0x0

    cmp-long p1, p3, v0

    if-nez p1, :cond_0

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    const v1, 0x7f0f00a2

    const v2, 0x7f0f0233

    const v3, 0x7f0f04ce

    const v4, 0x7f0f0480

    new-instance v5, Lchat/ola/vn/entry/c/b$2;

    invoke-direct {v5, p0}, Lchat/ola/vn/entry/c/b$2;-><init>(Lchat/ola/vn/entry/c/b;)V

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    goto :goto_0

    :cond_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    const p3, 0x7f0f00a2

    const p4, 0x7f0f024d

    invoke-static {p1, p3, p4}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    :goto_0
    const/4 p1, 0x0

    invoke-virtual {p2, p1}, Lchat/ola/vn/r/a/e;->a(Z)V

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 7

    const/4 v0, 0x0

    :try_start_0
    aget-object v1, p1, v0

    check-cast v1, Ljava/lang/String;

    const/4 v2, 0x0

    array-length v3, p1

    const/4 v4, 0x2

    if-le v3, v4, :cond_0

    aget-object p1, p1, v4

    move-object v2, p1

    check-cast v2, [Lchat/ola/vn/entity/g;

    :cond_0
    if-eqz v2, :cond_3

    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->i()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v3

    if-lez v3, :cond_1

    new-instance v3, Lchat/ola/vn/entry/a;

    invoke-direct {v3}, Lchat/ola/vn/entry/a;-><init>()V

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v4, v3, Lchat/ola/vn/entry/a;->a:Ljava/util/List;

    iput-object p1, v3, Lchat/ola/vn/entry/a;->b:Ljava/lang/String;

    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->a()S

    move-result p1

    iput-short p1, v3, Lchat/ola/vn/entry/a;->e:S

    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1, v3}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/entry/a;)V

    :cond_1
    iget-wide v3, p0, Lchat/ola/vn/entry/c/b;->a:J

    const-wide/16 v5, 0x0

    cmp-long p1, v3, v5

    if-nez p1, :cond_2

    const-string p1, "mariage diary"

    invoke-static {v2}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-direct {p0, p1, v0, v1}, Lchat/ola/vn/entry/c/b;->a(Ljava/lang/String;SLjava/util/List;)V

    goto :goto_0

    :cond_2
    invoke-static {v2}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/c/b;->a(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :cond_3
    :try_start_1
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    if-eqz p1, :cond_4

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    const v2, 0x7f0f00a2

    const v3, 0x7f0f0233

    const v4, 0x7f0f04ce

    const v5, 0x7f0f0480

    new-instance v6, Lchat/ola/vn/entry/c/b$1;

    invoke-direct {v6, p0}, Lchat/ola/vn/entry/c/b$1;-><init>(Lchat/ola/vn/entry/c/b;)V

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    goto :goto_0

    :catch_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    if-eqz p1, :cond_4

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    const v1, 0x7f0f009f

    const v2, 0x7f0f024e

    invoke-static {p1, v1, v2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_4
    :goto_0
    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1, v0}, Lchat/ola/vn/r/a/e;->a(Z)V

    return-void
.end method
