.class public Lchat/ola/vn/entity/x;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Comparable;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/lang/Comparable<",
        "Lchat/ola/vn/entity/x;",
        ">;"
    }
.end annotation


# instance fields
.field public a:B

.field public b:Ljava/lang/String;

.field public c:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/x;)I
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/entity/x;->a()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/x;->a()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/String;->compareToIgnoreCase(Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    return-object v0
.end method

.method public synthetic compareTo(Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/x;

    invoke-virtual {p0, p1}, Lchat/ola/vn/entity/x;->a(Lchat/ola/vn/entity/x;)I

    move-result p1

    return p1
.end method
