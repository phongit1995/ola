.class public Lchat/ola/vn/entry/a/d;
.super Lchat/ola/vn/entry/a/c;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entry/a/c<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field private f:[Ljava/lang/String;

.field private g:[Ljava/lang/String;


# direct methods
.method public constructor <init>(SLjava/lang/String;Ljava/lang/String;IILjava/lang/String;)V
    .locals 6

    const/4 v2, 0x1

    move-object v0, p0

    move v1, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p6

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/entry/a/c;-><init>(SSLjava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->b()Landroid/content/res/Resources;

    move-result-object p1

    invoke-virtual {p1, p5}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/a/d;->g:[Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->b()Landroid/content/res/Resources;

    move-result-object p1

    invoke-virtual {p1, p4}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/a/d;->f:[Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Landroid/content/res/Resources$NotFoundException;->printStackTrace()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/entry/a/d;)[Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/a/d;->g:[Ljava/lang/String;

    return-object p0
.end method

.method private b(Landroid/content/Context;)Z
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/entry/a/d;->f:[Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/a/d;->g:[Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/a/d;->f:[Ljava/lang/String;

    array-length v0, v0

    iget-object v1, p0, Lchat/ola/vn/entry/a/d;->g:[Ljava/lang/String;

    array-length v1, v1

    if-ne v0, v1, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/entry/a/d;->f:[Ljava/lang/String;

    invoke-static {v0, v1}, Ljava/util/Collections;->addAll(Ljava/util/Collection;[Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance p1, Lchat/ola/vn/entry/a/d$1;

    invoke-direct {p1, p0, v1}, Lchat/ola/vn/entry/a/d$1;-><init>(Lchat/ola/vn/entry/a/d;Lchat/ola/vn/i/m;)V

    invoke-virtual {v1, p1}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method


# virtual methods
.method public a(Landroid/content/Context;)Z
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/a/d;->b(Landroid/content/Context;)Z

    move-result p1

    return p1
.end method

.method public f()Ljava/lang/String;
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/entry/a/d;->g:[Ljava/lang/String;

    array-length v0, v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    iget-object v2, p0, Lchat/ola/vn/entry/a/d;->g:[Ljava/lang/String;

    aget-object v2, v2, v1

    iget-object v3, p0, Lchat/ola/vn/entry/a/d;->d:Ljava/lang/Object;

    check-cast v3, Ljava/lang/String;

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/a/d;->f:[Ljava/lang/String;

    aget-object v0, v0, v1

    return-object v0

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/a/d;->d:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method
