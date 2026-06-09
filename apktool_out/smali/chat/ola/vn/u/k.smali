.class Lchat/ola/vn/u/k;
.super Ljava/lang/Object;


# static fields
.field static a:[Lchat/ola/vn/u/a;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    const/4 v0, 0x5

    new-array v0, v0, [Lchat/ola/vn/u/a;

    sput-object v0, Lchat/ola/vn/u/k;->a:[Lchat/ola/vn/u/a;

    sget-object v0, Lchat/ola/vn/u/k;->a:[Lchat/ola/vn/u/a;

    new-instance v1, Lchat/ola/vn/u/f;

    invoke-direct {v1}, Lchat/ola/vn/u/f;-><init>()V

    const/4 v2, 0x0

    aput-object v1, v0, v2

    sget-object v0, Lchat/ola/vn/u/k;->a:[Lchat/ola/vn/u/a;

    new-instance v1, Lchat/ola/vn/u/i;

    invoke-direct {v1}, Lchat/ola/vn/u/i;-><init>()V

    const/4 v2, 0x1

    aput-object v1, v0, v2

    sget-object v0, Lchat/ola/vn/u/k;->a:[Lchat/ola/vn/u/a;

    new-instance v1, Lchat/ola/vn/u/l;

    invoke-direct {v1}, Lchat/ola/vn/u/l;-><init>()V

    const/4 v2, 0x2

    aput-object v1, v0, v2

    sget-object v0, Lchat/ola/vn/u/k;->a:[Lchat/ola/vn/u/a;

    new-instance v1, Lchat/ola/vn/u/c;

    invoke-direct {v1}, Lchat/ola/vn/u/c;-><init>()V

    const/4 v2, 0x3

    aput-object v1, v0, v2

    sget-object v0, Lchat/ola/vn/u/k;->a:[Lchat/ola/vn/u/a;

    new-instance v1, Lchat/ola/vn/u/j;

    invoke-direct {v1}, Lchat/ola/vn/u/j;-><init>()V

    const/4 v2, 0x4

    aput-object v1, v0, v2

    return-void
.end method

.method public static a(S)Lchat/ola/vn/u/a;
    .locals 1

    if-ltz p0, :cond_1

    sget-object v0, Lchat/ola/vn/u/k;->a:[Lchat/ola/vn/u/a;

    array-length v0, v0

    if-lt p0, v0, :cond_0

    goto :goto_0

    :cond_0
    sget-object v0, Lchat/ola/vn/u/k;->a:[Lchat/ola/vn/u/a;

    aget-object p0, v0, p0

    return-object p0

    :cond_1
    :goto_0
    const/4 p0, 0x0

    return-object p0
.end method
