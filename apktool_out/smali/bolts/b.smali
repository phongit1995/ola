.class public Lbolts/b;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lbolts/b$a;
    }
.end annotation


# instance fields
.field private a:Landroid/net/Uri;

.field private b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lbolts/b$a;",
            ">;"
        }
    .end annotation
.end field

.field private c:Landroid/net/Uri;


# direct methods
.method public constructor <init>(Landroid/net/Uri;Ljava/util/List;Landroid/net/Uri;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/net/Uri;",
            "Ljava/util/List<",
            "Lbolts/b$a;",
            ">;",
            "Landroid/net/Uri;",
            ")V"
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lbolts/b;->a:Landroid/net/Uri;

    if-nez p2, :cond_0

    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object p2

    :cond_0
    iput-object p2, p0, Lbolts/b;->b:Ljava/util/List;

    iput-object p3, p0, Lbolts/b;->c:Landroid/net/Uri;

    return-void
.end method
