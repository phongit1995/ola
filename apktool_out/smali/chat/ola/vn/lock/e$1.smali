.class Lchat/ola/vn/lock/e$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/lock/e;->v()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/lock/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/lock/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/lock/e$1;->a:Lchat/ola/vn/lock/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    const-wide/16 p1, 0x0

    packed-switch p3, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    const-wide/32 p1, 0xdbba00

    :try_start_0
    sput-wide p1, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    goto :goto_1

    :pswitch_1
    const-wide/32 p1, 0x36ee80

    sput-wide p1, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    goto :goto_1

    :pswitch_2
    const-wide/32 p1, 0xdbba0

    sput-wide p1, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    goto :goto_1

    :pswitch_3
    const-wide/32 p1, 0x493e0

    sput-wide p1, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    goto :goto_1

    :pswitch_4
    const-wide/32 p1, 0xea60

    sput-wide p1, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    goto :goto_1

    :goto_0
    :pswitch_5
    sput-wide p1, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    :goto_1
    sget-object p1, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    if-nez p1, :cond_0

    new-instance p1, Lchat/ola/vn/entity/r;

    invoke-direct {p1}, Lchat/ola/vn/entity/r;-><init>()V

    sput-object p1, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    :cond_0
    sget-object p1, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    sget-wide p2, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    iput-wide p2, p1, Lchat/ola/vn/entity/r;->c:J

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    sget-object p2, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->e:Lchat/ola/vn/entity/r;

    invoke-virtual {p2}, Lchat/ola/vn/entity/r;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/e;->p(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/lock/e$1;->a:Lchat/ola/vn/lock/e;

    invoke-static {p1}, Lchat/ola/vn/lock/e;->a(Lchat/ola/vn/lock/e;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
