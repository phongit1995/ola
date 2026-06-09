.class public abstract Lchat/ola/vn/entity/m;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field public a:J

.field public b:Z


# direct methods
.method public constructor <init>(J)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/entity/m;->b:Z

    iput-wide p1, p0, Lchat/ola/vn/entity/m;->a:J

    iput-boolean v0, p0, Lchat/ola/vn/entity/m;->b:Z

    return-void
.end method


# virtual methods
.method public abstract a([B)Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B)TT;"
        }
    .end annotation
.end method

.method public abstract a()Ljava/lang/String;
.end method

.method public abstract a(Ljava/lang/Object;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation
.end method

.method public final a(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/entity/m$2;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/entity/m$2;-><init>(Lchat/ola/vn/entity/m;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public final a([BLjava/lang/String;)V
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/entity/m;->a([B)Ljava/lang/Object;

    move-result-object p1

    new-instance p2, Lchat/ola/vn/entity/m$1;

    invoke-direct {p2, p0, p1}, Lchat/ola/vn/entity/m$1;-><init>(Lchat/ola/vn/entity/m;Ljava/lang/Object;)V

    invoke-static {p2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public abstract b(Ljava/lang/String;)V
.end method
