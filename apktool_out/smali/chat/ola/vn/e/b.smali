.class public Lchat/ola/vn/e/b;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Ljava/io/File;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/io/File;Ljava/io/File;)I
    .locals 8

    invoke-virtual {p1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/entity/w;->b(Ljava/lang/String;)Z

    move-result v0

    invoke-virtual {p2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/entity/w;->b(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    if-eqz v1, :cond_0

    return v2

    :cond_0
    const/4 v3, 0x1

    if-eqz v0, :cond_1

    return v3

    :cond_1
    const/4 v0, -0x1

    if-eqz v1, :cond_2

    return v0

    :cond_2
    invoke-virtual {p1}, Ljava/io/File;->lastModified()J

    move-result-wide v4

    invoke-virtual {p2}, Ljava/io/File;->lastModified()J

    move-result-wide v6

    cmp-long v1, v4, v6

    if-lez v1, :cond_3

    return v3

    :cond_3
    invoke-virtual {p1}, Ljava/io/File;->lastModified()J

    move-result-wide v3

    invoke-virtual {p2}, Ljava/io/File;->lastModified()J

    move-result-wide p1

    cmp-long v1, v3, p1

    if-gez v1, :cond_4

    return v0

    :cond_4
    return v2
.end method

.method public synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Ljava/io/File;

    check-cast p2, Ljava/io/File;

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/e/b;->a(Ljava/io/File;Ljava/io/File;)I

    move-result p1

    return p1
.end method
