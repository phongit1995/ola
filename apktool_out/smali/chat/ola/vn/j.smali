.class public Lchat/ola/vn/j;
.super Ljava/lang/Object;


# static fields
.field private static b:Lchat/ola/vn/j;


# instance fields
.field private a:[Lchat/ola/vn/h/c;

.field private c:Landroid/graphics/Bitmap;


# direct methods
.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0xff

    new-array v0, v0, [Lchat/ola/vn/h/c;

    iput-object v0, p0, Lchat/ola/vn/j;->a:[Lchat/ola/vn/h/c;

    invoke-direct {p0}, Lchat/ola/vn/j;->b()V

    return-void
.end method

.method public static a()Lchat/ola/vn/j;
    .locals 1

    sget-object v0, Lchat/ola/vn/j;->b:Lchat/ola/vn/j;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/j;

    invoke-direct {v0}, Lchat/ola/vn/j;-><init>()V

    sput-object v0, Lchat/ola/vn/j;->b:Lchat/ola/vn/j;

    :cond_0
    sget-object v0, Lchat/ola/vn/j;->b:Lchat/ola/vn/j;

    return-object v0
.end method

.method private b()V
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h/b;->d()Ljava/util/List;

    move-result-object v0

    invoke-virtual {p0, v0}, Lchat/ola/vn/j;->a(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method


# virtual methods
.method public a(I)Landroid/graphics/Bitmap;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/j;->a:[Lchat/ola/vn/h/c;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/j;->a:[Lchat/ola/vn/h/c;

    aget-object p1, v0, p1

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/h/c;->a()Landroid/graphics/Bitmap;

    move-result-object p1

    return-object p1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/j;->c:Landroid/graphics/Bitmap;

    if-nez p1, :cond_1

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v0, 0x7f08082c

    invoke-static {p1, v0}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/j;->c:Landroid/graphics/Bitmap;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    iget-object p1, p0, Lchat/ola/vn/j;->c:Landroid/graphics/Bitmap;

    return-object p1
.end method

.method public a(Ljava/util/List;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ah;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_1

    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/ah;

    invoke-virtual {v3}, Lchat/ola/vn/entity/ah;->c()[B

    move-result-object v4

    invoke-virtual {v3}, Lchat/ola/vn/entity/ah;->c()[B

    move-result-object v5

    array-length v5, v5

    invoke-static {v4, v1, v5}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object v4

    if-eqz v4, :cond_0

    const/4 v5, 0x0

    invoke-virtual {v3, v5}, Lchat/ola/vn/entity/ah;->a([B)V

    invoke-static {v3}, Lchat/ola/vn/h/c;->a(Lchat/ola/vn/entity/ah;)Lchat/ola/vn/h/c;

    move-result-object v3

    invoke-virtual {v3, v4}, Lchat/ola/vn/h/c;->a(Landroid/graphics/Bitmap;)V

    iget-object v4, p0, Lchat/ola/vn/j;->a:[Lchat/ola/vn/h/c;

    invoke-virtual {v3}, Lchat/ola/vn/h/c;->b()I

    move-result v5

    aput-object v3, v4, v5

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    new-instance p1, Lchat/ola/vn/h/c;

    invoke-direct {p1, v1}, Lchat/ola/vn/h/c;-><init>(I)V

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Lchat/ola/vn/h/c;->a(Z)V

    const-string v0, "Online"

    invoke-virtual {p1, v0}, Lchat/ola/vn/h/c;->a(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/j;->c:Landroid/graphics/Bitmap;

    if-nez v0, :cond_2

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v2, 0x7f08082c

    invoke-static {v0, v2}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/j;->c:Landroid/graphics/Bitmap;

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/j;->c:Landroid/graphics/Bitmap;

    invoke-virtual {p1, v0}, Lchat/ola/vn/h/c;->a(Landroid/graphics/Bitmap;)V

    iget-object v0, p0, Lchat/ola/vn/j;->a:[Lchat/ola/vn/h/c;

    aput-object p1, v0, v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b(I)Lchat/ola/vn/entity/ah;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/j;->a:[Lchat/ola/vn/h/c;

    aget-object p1, v0, p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/j;->a:[Lchat/ola/vn/h/c;

    const/4 v0, 0x0

    aget-object p1, p1, v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method
