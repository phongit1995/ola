.class public Lchat/ola/vn/game/caro/a;
.super Ljava/lang/Object;


# static fields
.field public static a:S = 0x1s

.field public static b:S = 0x2s


# instance fields
.field public c:I

.field public d:I

.field public e:S


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(IIS)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lchat/ola/vn/game/caro/a;->c:I

    iput p2, p0, Lchat/ola/vn/game/caro/a;->d:I

    iput-short p3, p0, Lchat/ola/vn/game/caro/a;->e:S

    return-void
.end method
