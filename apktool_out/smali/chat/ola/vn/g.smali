.class public Lchat/ola/vn/g;
.super Ljava/lang/Object;


# static fields
.field static a:Ljava/util/List; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/x;",
            ">;"
        }
    .end annotation
.end field

.field static b:Ljava/util/Map; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lchat/ola/vn/entity/x;",
            ">;"
        }
    .end annotation
.end field

.field public static c:Z = false

.field private static d:Lchat/ola/vn/e/l;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lchat/ola/vn/g;->a:Ljava/util/List;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lchat/ola/vn/g;->b:Ljava/util/Map;

    return-void
.end method

.method public static a()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/x;",
            ">;"
        }
    .end annotation

    sget-object v0, Lchat/ola/vn/g;->a:Ljava/util/List;

    return-object v0
.end method

.method public static a(Lchat/ola/vn/entity/x;)V
    .locals 2

    if-nez p0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/g;->b:Ljava/util/Map;

    invoke-virtual {p0}, Lchat/ola/vn/entity/x;->a()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/x;

    if-nez v0, :cond_1

    sget-object v0, Lchat/ola/vn/g;->a:Ljava/util/List;

    invoke-interface {v0, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    sget-object v0, Lchat/ola/vn/g;->b:Ljava/util/Map;

    invoke-virtual {p0}, Lchat/ola/vn/entity/x;->a()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1, p0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/entity/x;->b:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    iget-object p0, p0, Lchat/ola/vn/entity/x;->b:Ljava/lang/String;

    iput-object p0, v0, Lchat/ola/vn/entity/x;->b:Ljava/lang/String;

    :cond_2
    :goto_0
    sget-object p0, Lchat/ola/vn/g;->d:Lchat/ola/vn/e/l;

    if-nez p0, :cond_3

    new-instance p0, Lchat/ola/vn/e/l;

    invoke-direct {p0}, Lchat/ola/vn/e/l;-><init>()V

    sput-object p0, Lchat/ola/vn/g;->d:Lchat/ola/vn/e/l;

    :cond_3
    sget-object p0, Lchat/ola/vn/g;->a:Ljava/util/List;

    sget-object v0, Lchat/ola/vn/g;->d:Lchat/ola/vn/e/l;

    invoke-static {p0, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    return-void
.end method

.method public static b()V
    .locals 1

    :try_start_0
    sget-object v0, Lchat/ola/vn/g;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    sget-object v0, Lchat/ola/vn/g;->b:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    const/4 v0, 0x0

    sput-boolean v0, Lchat/ola/vn/g;->c:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
