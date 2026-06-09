.class public Lchat/ola/vn/message/a;
.super Lchat/ola/vn/message/f;


# instance fields
.field public a:J

.field public b:J


# direct methods
.method public constructor <init>()V
    .locals 2

    const-string v0, "admob-native"

    const/4 v1, 0x6

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/message/a;->a:J

    iput-wide v0, p0, Lchat/ola/vn/message/a;->b:J

    return-void
.end method


# virtual methods
.method public a()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/message/a;->b:J

    return-wide v0
.end method
