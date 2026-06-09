.class public Lchat/ola/vn/activity/OlaAppSettingActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/ExpandableListView$OnChildClickListener;
.implements Lchat/ola/vn/entry/a/c$a;


# instance fields
.field private e:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/entry/a/b;",
            ">;"
        }
    .end annotation
.end field

.field private f:Lchat/ola/vn/b/b;

.field private g:Landroid/widget/ExpandableListView;

.field private h:Lcom/facebook/share/widget/LikeView;

.field private i:I


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->i:I

    return-void
.end method

.method private B()V
    .locals 12

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->e:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->e:Ljava/util/ArrayList;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    :goto_0
    new-instance v0, Lchat/ola/vn/entry/a/b;

    const v1, 0x7f0f06dd

    invoke-direct {v0, v1}, Lchat/ola/vn/entry/a/b;-><init>(I)V

    new-instance v1, Lchat/ola/vn/entry/a/d;

    const/16 v3, 0x3f

    const v2, 0x7f0f06d2

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v2, 0x7f0f06c6

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    const v6, 0x7f03000f

    const v7, 0x7f030029

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget-byte v8, Lchat/ola/vn/c/x;->n:B

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v8, ""

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    move-object v2, v1

    invoke-direct/range {v2 .. v8}, Lchat/ola/vn/entry/a/d;-><init>(SLjava/lang/String;Ljava/lang/String;IILjava/lang/String;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/d;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    new-instance v1, Lchat/ola/vn/entry/a/d;

    const/16 v3, 0x42

    const v2, 0x7f0f06e7

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v2, 0x7f0f06c9

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    const v6, 0x7f030010

    const v7, 0x7f03002a

    invoke-static {}, Lchat/ola/vn/c/x;->c()Ljava/lang/String;

    move-result-object v8

    move-object v2, v1

    invoke-direct/range {v2 .. v8}, Lchat/ola/vn/entry/a/d;-><init>(SLjava/lang/String;Ljava/lang/String;IILjava/lang/String;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/d;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    new-instance v1, Lchat/ola/vn/entry/a/d;

    const/16 v3, 0x40

    const v2, 0x7f0f06d4

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v2, 0x7f0f06c7

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    const v6, 0x7f030011

    const v7, 0x7f03002b

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget-byte v8, Lchat/ola/vn/c/x;->o:B

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v8, ""

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    move-object v2, v1

    invoke-direct/range {v2 .. v8}, Lchat/ola/vn/entry/a/d;-><init>(SLjava/lang/String;Ljava/lang/String;IILjava/lang/String;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/d;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    new-instance v1, Lchat/ola/vn/entry/a/e;

    const/16 v2, 0x41

    const v3, 0x7f0f03e4

    invoke-virtual {p0, v3}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    const v4, 0x7f0f03e3

    invoke-virtual {p0, v4}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    sget-boolean v5, Lchat/ola/vn/c/x;->q:Z

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    invoke-direct {v1, v2, v3, v4, v5}, Lchat/ola/vn/entry/a/e;-><init>(SLjava/lang/String;Ljava/lang/String;Ljava/lang/Boolean;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/e;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/e;->l()Ljava/lang/String;

    move-result-object v1

    const-string v2, "vi"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    const/4 v3, 0x2

    const/4 v4, 0x0

    if-eqz v2, :cond_1

    const/4 v1, 0x1

    goto :goto_1

    :cond_1
    const-string v2, "en"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    const/4 v1, 0x2

    goto :goto_1

    :cond_2
    const/4 v1, 0x0

    :goto_1
    new-instance v2, Lchat/ola/vn/entry/a/d;

    const/16 v6, 0x64

    const v5, 0x7f0f06df

    invoke-virtual {p0, v5}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    const v5, 0x7f0f06c8

    invoke-virtual {p0, v5}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v8

    const v9, 0x7f03000a

    const v10, 0x7f030024

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ""

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    move-object v5, v2

    invoke-direct/range {v5 .. v11}, Lchat/ola/vn/entry/a/d;-><init>(SLjava/lang/String;Ljava/lang/String;IILjava/lang/String;)V

    invoke-virtual {v2, p0}, Lchat/ola/vn/entry/a/d;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    new-instance v1, Lchat/ola/vn/entry/a/a;

    const/16 v2, 0x2d

    const v5, 0x7f0f06e6

    invoke-virtual {p0, v5}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    const v6, 0x7f0f02e0

    invoke-virtual {p0, v6}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v6

    const-string v7, ""

    invoke-direct {v1, v2, v5, v6, v7}, Lchat/ola/vn/entry/a/a;-><init>(SLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/a;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->e:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v0, Lchat/ola/vn/entry/a/b;

    const v1, 0x7f0f06dc

    invoke-direct {v0, v1}, Lchat/ola/vn/entry/a/b;-><init>(I)V

    new-instance v1, Lchat/ola/vn/entry/a/e;

    const/16 v2, 0x43

    const v5, 0x7f0f03ea

    invoke-virtual {p0, v5}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    const v6, 0x7f0f03e9

    invoke-virtual {p0, v6}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v6

    sget-boolean v7, Lchat/ola/vn/c/x;->h:Z

    invoke-static {v7}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v7

    invoke-direct {v1, v2, v5, v6, v7}, Lchat/ola/vn/entry/a/e;-><init>(SLjava/lang/String;Ljava/lang/String;Ljava/lang/Boolean;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/e;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    sget-byte v1, Lchat/ola/vn/c/x;->m:B

    const/4 v2, 0x3

    if-le v1, v2, :cond_3

    sput-byte v3, Lchat/ola/vn/c/x;->m:B

    :cond_3
    new-instance v1, Lchat/ola/vn/entry/a/d;

    const/16 v6, 0x3b

    const v2, 0x7f0f03de

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    const v2, 0x7f0f03dd

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v8

    const v9, 0x7f03000d

    const v10, 0x7f030027

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget-byte v5, Lchat/ola/vn/c/x;->m:B

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v5, ""

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    move-object v5, v1

    invoke-direct/range {v5 .. v11}, Lchat/ola/vn/entry/a/d;-><init>(SLjava/lang/String;Ljava/lang/String;IILjava/lang/String;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/d;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    const-string v1, "0"
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/h/b;->c(Ljava/lang/String;)[B

    move-result-object v2

    if-eqz v2, :cond_4

    array-length v2, v2

    if-lez v2, :cond_4

    const-string v2, "1"
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object v1, v2

    :catch_0
    :cond_4
    move-object v11, v1

    :try_start_2
    new-instance v1, Lchat/ola/vn/entry/a/d;

    const/16 v6, 0x5d

    const v2, 0x7f0f03f9

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    const/4 v8, 0x0

    const v9, 0x7f03001a

    const v10, 0x7f03001b

    move-object v5, v1

    invoke-direct/range {v5 .. v11}, Lchat/ola/vn/entry/a/d;-><init>(SLjava/lang/String;Ljava/lang/String;IILjava/lang/String;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/d;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    new-instance v1, Lchat/ola/vn/entry/a/e;

    const/16 v2, 0x6e

    const v5, 0x7f0f03da

    invoke-virtual {p0, v5}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    const v6, 0x7f0f03d9

    invoke-virtual {p0, v6}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v6

    sget-boolean v7, Lchat/ola/vn/c/x;->x:Z

    invoke-static {v7}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v7

    invoke-direct {v1, v2, v5, v6, v7}, Lchat/ola/vn/entry/a/e;-><init>(SLjava/lang/String;Ljava/lang/String;Ljava/lang/Boolean;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/e;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    new-instance v1, Lchat/ola/vn/entry/a/d;

    const/16 v6, 0x65

    const v2, 0x7f0f03dc

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    const v2, 0x7f0f03db

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v8

    const v9, 0x7f03000e

    const v10, 0x7f030028

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget-byte v5, Lchat/ola/vn/c/x;->p:B

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v5, ""

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    move-object v5, v1

    invoke-direct/range {v5 .. v11}, Lchat/ola/vn/entry/a/d;-><init>(SLjava/lang/String;Ljava/lang/String;IILjava/lang/String;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/d;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    new-instance v1, Lchat/ola/vn/entry/a/e;

    const/16 v2, 0x5b

    const v5, 0x7f0f03f4

    invoke-virtual {p0, v5}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    const v6, 0x7f0f03f3

    invoke-virtual {p0, v6}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v6

    sget-boolean v7, Lchat/ola/vn/c/x;->r:Z

    invoke-static {v7}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v7

    invoke-direct {v1, v2, v5, v6, v7}, Lchat/ola/vn/entry/a/e;-><init>(SLjava/lang/String;Ljava/lang/String;Ljava/lang/Boolean;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/e;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->e:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v0, Lchat/ola/vn/entry/a/b;

    const v1, 0x7f0f06d3

    invoke-direct {v0, v1}, Lchat/ola/vn/entry/a/b;-><init>(I)V

    sget-byte v1, Lchat/ola/vn/c/x;->k:B

    if-le v1, v3, :cond_5

    sput-byte v4, Lchat/ola/vn/c/x;->k:B

    :cond_5
    new-instance v1, Lchat/ola/vn/entry/a/d;

    const/16 v6, 0x38

    const v2, 0x7f0f035d

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    const/4 v8, 0x0

    const v9, 0x7f03001c

    const v10, 0x7f03001d

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget-byte v3, Lchat/ola/vn/c/x;->k:B

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    move-object v5, v1

    invoke-direct/range {v5 .. v11}, Lchat/ola/vn/entry/a/d;-><init>(SLjava/lang/String;Ljava/lang/String;IILjava/lang/String;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/d;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    new-instance v1, Lchat/ola/vn/entry/a/e;

    const/16 v2, 0x70

    const v3, 0x7f0f03ed

    invoke-virtual {p0, v3}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    const v5, 0x7f0f03ec

    invoke-virtual {p0, v5}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    sget-boolean v6, Lchat/ola/vn/c/x;->y:Z

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    invoke-direct {v1, v2, v3, v5, v6}, Lchat/ola/vn/entry/a/e;-><init>(SLjava/lang/String;Ljava/lang/String;Ljava/lang/Boolean;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/e;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    new-instance v1, Lchat/ola/vn/entry/a/d;

    const/16 v6, 0x56

    const v2, 0x7f0f03e8

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    const v2, 0x7f0f03e7

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v8

    const v9, 0x7f03000c

    const v10, 0x7f030026

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget-byte v3, Lchat/ola/vn/c/x;->l:B

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    move-object v5, v1

    invoke-direct/range {v5 .. v11}, Lchat/ola/vn/entry/a/d;-><init>(SLjava/lang/String;Ljava/lang/String;IILjava/lang/String;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/d;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->e:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v0, Lchat/ola/vn/entry/a/b;

    const v1, 0x7f0f06e8

    invoke-direct {v0, v1}, Lchat/ola/vn/entry/a/b;-><init>(I)V

    new-instance v1, Lchat/ola/vn/entry/a/e;

    const/16 v2, 0x68

    const v3, 0x7f0f03f2

    invoke-virtual {p0, v3}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    const/4 v5, 0x0

    sget-boolean v6, Lchat/ola/vn/c/x;->t:Z

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    invoke-direct {v1, v2, v3, v5, v6}, Lchat/ola/vn/entry/a/e;-><init>(SLjava/lang/String;Ljava/lang/String;Ljava/lang/Boolean;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/e;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    new-instance v1, Lchat/ola/vn/entry/a/a;

    const/16 v2, 0x57

    const v3, 0x7f0f03ef

    invoke-virtual {p0, v3}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    const v5, 0x7f0f03ee

    invoke-virtual {p0, v5}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    sget v7, Lchat/ola/vn/c/x;->i:I

    invoke-direct {p0, v7}, Lchat/ola/vn/activity/OlaAppSettingActivity;->c(I)I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v7, ""

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v1, v2, v3, v5, v6}, Lchat/ola/vn/entry/a/a;-><init>(SLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/a;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->e:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v0, Lchat/ola/vn/entry/a/b;

    const v1, 0x7f0f06e3

    invoke-direct {v0, v1}, Lchat/ola/vn/entry/a/b;-><init>(I)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v4}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v3, v1, Landroid/content/pm/PackageInfo;->versionCode:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    iget-object v1, v1, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    const-string v3, "5.10.19"

    new-instance v4, Lchat/ola/vn/entry/a/a;

    const/16 v5, 0x13

    const v6, 0x7f0f06e5

    invoke-virtual {p0, v6}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v6

    const v7, 0x7f0f0311

    invoke-virtual {p0, v7}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    const-string v8, ""

    invoke-direct {v4, v5, v6, v7, v8}, Lchat/ola/vn/entry/a/a;-><init>(SLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v4, p0}, Lchat/ola/vn/entry/a/a;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v4

    invoke-virtual {v0, v4}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    new-instance v4, Lchat/ola/vn/entry/a/a;

    const/16 v5, 0x14

    const v6, 0x7f0f06e2

    invoke-virtual {p0, v6}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v6

    const v7, 0x7f0f0378

    invoke-virtual {p0, v7}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    const-string v8, ""

    invoke-direct {v4, v5, v6, v7, v8}, Lchat/ola/vn/entry/a/a;-><init>(SLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v4, p0}, Lchat/ola/vn/entry/a/a;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v4

    invoke-virtual {v0, v4}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    new-instance v4, Lchat/ola/vn/entry/a/a;

    const/16 v5, 0x5c

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const v7, 0x7f0f03f6

    invoke-virtual {p0, v7}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v7, ": "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ""

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const v7, 0x7f0f03f5

    invoke-virtual {p0, v7}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v7, ": "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "\n"

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f03eb

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ": "

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "\n"

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f03d6

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ": "

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v2, Lchat/ola/vn/f/a;->n:Ljava/lang/String;

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "\n"

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f03f7

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ": "

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f0024

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "\nCopyright 2007-2016 MicroGame Corp.\n"

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f03f8

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ":\n"

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "1900588883"

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, ""

    invoke-direct {v4, v5, v1, v2, v3}, Lchat/ola/vn/entry/a/a;-><init>(SLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v4, p0}, Lchat/ola/vn/entry/a/a;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    new-instance v1, Lchat/ola/vn/entry/a/a;

    const/16 v2, 0x6c

    const v3, 0x7f0f054f

    invoke-virtual {p0, v3}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    const v4, 0x7f0f02ab

    invoke-virtual {p0, v4}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const-string v5, ""

    invoke-direct {v1, v2, v3, v4, v5}, Lchat/ola/vn/entry/a/a;-><init>(SLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/a/a;->a(Lchat/ola/vn/entry/a/c$a;)Lchat/ola/vn/entry/a/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/a/b;->a(Lchat/ola/vn/entry/a/c;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->e:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private C()V
    .locals 4

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    if-eqz v0, :cond_0

    new-instance v0, Lchat/ola/vn/i/j;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    const/4 v2, 0x1

    new-instance v3, Lchat/ola/vn/activity/OlaAppSettingActivity$3;

    invoke-direct {v3, p0}, Lchat/ola/vn/activity/OlaAppSettingActivity$3;-><init>(Lchat/ola/vn/activity/OlaAppSettingActivity;)V

    invoke-direct {v0, v1, v2, v3}, Lchat/ola/vn/i/j;-><init>(Landroid/content/Context;ZLchat/ola/vn/i/j$a;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/j;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private D()V
    .locals 3

    new-instance v0, Lchat/ola/vn/i/n;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/n;-><init>(Landroid/content/Context;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/n;->requestWindowFeature(I)Z

    const v2, 0x7f0b00a9

    invoke-virtual {v0, v2}, Lchat/ola/vn/i/n;->setContentView(I)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/n;->setCanceledOnTouchOutside(Z)V

    invoke-virtual {v0}, Lchat/ola/vn/i/n;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v1

    const/4 v2, -0x1

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->width:I

    const v1, 0x7f090561

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/n;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    const/high16 v2, 0x41400000    # 12.0f

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextSize(F)V

    const v1, 0x7f090544

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/n;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    const/high16 v2, 0x41c00000    # 24.0f

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextSize(F)V

    const v1, 0x7f090477

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/n;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/SeekBar;

    const/16 v2, 0xa

    invoke-virtual {v1, v2}, Landroid/widget/SeekBar;->setMax(I)V

    sget v2, Lchat/ola/vn/c/x;->i:I

    invoke-virtual {v1, v2}, Landroid/widget/SeekBar;->setProgress(I)V

    new-instance v2, Lchat/ola/vn/activity/OlaAppSettingActivity$4;

    invoke-direct {v2, p0}, Lchat/ola/vn/activity/OlaAppSettingActivity$4;-><init>(Lchat/ola/vn/activity/OlaAppSettingActivity;)V

    invoke-virtual {v1, v2}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    new-instance v1, Lchat/ola/vn/activity/OlaAppSettingActivity$5;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaAppSettingActivity$5;-><init>(Lchat/ola/vn/activity/OlaAppSettingActivity;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/n;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/n;->show()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaAppSettingActivity;)Lchat/ola/vn/b/b;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->f:Lchat/ola/vn/b/b;

    return-object p0
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    const/4 v0, 0x3

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lchat/ola/vn/activity/OlaAppSettingActivity;->a(Landroid/content/Context;II)V

    return-void
.end method

.method private static a(Landroid/content/Context;II)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/OlaAppSettingActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "groupIndex"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string p1, "rowIndex"

    invoke-virtual {v0, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const p2, 0x7f010039

    invoke-virtual {p0, p1, p2}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaAppSettingActivity;)Landroid/widget/ExpandableListView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->g:Landroid/widget/ExpandableListView;

    return-object p0
.end method

.method public static b(Landroid/content/Context;)V
    .locals 2

    const/4 v0, 0x4

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lchat/ola/vn/activity/OlaAppSettingActivity;->a(Landroid/content/Context;II)V

    return-void
.end method

.method private c(I)I
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f070170

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    mul-int/lit8 p1, p1, 0xa

    mul-int p1, p1, v0

    div-int/lit8 p1, p1, 0x64
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/2addr v0, p1

    return v0

    :catch_0
    const/4 p1, 0x0

    return p1
.end method

.method public static c(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0, v0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->a(Landroid/content/Context;II)V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/activity/OlaAppSettingActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->B()V

    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entry/a/c;Ljava/lang/Object;)V
    .locals 5

    :try_start_0
    invoke-virtual {p1}, Lchat/ola/vn/entry/a/c;->a()S

    move-result p1

    sparse-switch p1, :sswitch_data_0

    goto/16 :goto_2

    :sswitch_0
    check-cast p2, Ljava/lang/Boolean;

    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    sput-boolean p1, Lchat/ola/vn/c/x;->y:Z

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    sget-boolean p2, Lchat/ola/vn/c/x;->y:Z

    invoke-static {p1, p2}, Lchat/ola/vn/h/b;->f(Ljava/lang/String;Z)V

    sget-boolean p1, Lchat/ola/vn/c/x;->y:Z

    if-eqz p1, :cond_2

    invoke-static {p0}, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->a(Landroid/content/Context;)V

    goto/16 :goto_2

    :sswitch_1
    check-cast p2, Ljava/lang/Boolean;

    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    sput-boolean p1, Lchat/ola/vn/c/x;->x:Z

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    sget-boolean p2, Lchat/ola/vn/c/x;->x:Z

    invoke-static {p1, p2}, Lchat/ola/vn/h/b;->e(Ljava/lang/String;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    goto/16 :goto_2

    :sswitch_2
    :try_start_1
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->C()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto/16 :goto_2

    :sswitch_3
    :try_start_2
    check-cast p2, Ljava/lang/Boolean;

    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    sput-boolean p1, Lchat/ola/vn/c/x;->u:Z

    goto/16 :goto_2

    :sswitch_4
    check-cast p2, Ljava/lang/Boolean;

    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    sput-boolean p1, Lchat/ola/vn/c/x;->t:Z

    goto/16 :goto_2

    :sswitch_5
    check-cast p2, Ljava/lang/String;

    invoke-static {p2}, Ljava/lang/Byte;->valueOf(Ljava/lang/String;)Ljava/lang/Byte;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Byte;->byteValue()B

    move-result p1

    sput-byte p1, Lchat/ola/vn/c/x;->p:B

    goto/16 :goto_2

    :sswitch_6
    check-cast p2, Ljava/lang/String;

    invoke-static {p2}, Ljava/lang/Byte;->valueOf(Ljava/lang/String;)Ljava/lang/Byte;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Byte;->byteValue()B

    move-result p1

    const p2, 0x7f0f00a2

    const v0, 0x7f0f0339

    invoke-static {p0, p2, v0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    const-string p2, "default"

    packed-switch p1, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    const-string p2, "en"

    goto :goto_0

    :pswitch_1
    const-string p2, "vi"

    :goto_0
    invoke-static {p2}, Lchat/ola/vn/c/x;->b(Ljava/lang/String;)V

    goto/16 :goto_2

    :sswitch_7
    check-cast p2, Ljava/lang/Boolean;

    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    sput-boolean p1, Lchat/ola/vn/c/x;->s:Z

    goto/16 :goto_2

    :sswitch_8
    check-cast p2, Ljava/lang/String;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    if-eqz p1, :cond_0

    invoke-static {p0}, Lchat/ola/vn/activity/OlaCropImageActivity;->a(Landroid/content/Context;)V

    goto/16 :goto_2

    :cond_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/activity/OlaBottomTabActivity;->E()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    goto/16 :goto_2

    :sswitch_9
    :try_start_3
    iget p1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->i:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->i:I

    iget p1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->i:I

    const/16 p2, 0x8

    if-lt p1, p2, :cond_2

    const/4 p1, 0x0

    iput p1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->i:I

    const-string p2, "Console"

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Max: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-wide v1, Lchat/ola/vn/c/f;->a:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, "ms\nAvg: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-wide v1, Lchat/ola/vn/c/f;->b:J

    sget v3, Lchat/ola/vn/c/f;->c:I

    int-to-long v3, v3

    div-long/2addr v1, v3

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, "ms\nTotal count: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget v1, Lchat/ola/vn/c/f;->c:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, p2, v0}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/app/Dialog;->setCanceledOnTouchOutside(Z)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto/16 :goto_2

    :sswitch_a
    :try_start_4
    check-cast p2, Ljava/lang/Boolean;

    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    sput-boolean p1, Lchat/ola/vn/c/x;->r:Z

    goto/16 :goto_2

    :sswitch_b
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->D()V

    goto/16 :goto_2

    :sswitch_c
    check-cast p2, Ljava/lang/String;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    int-to-byte p1, p1

    sput-byte p1, Lchat/ola/vn/c/x;->l:B

    goto/16 :goto_2

    :sswitch_d
    check-cast p2, Ljava/lang/Boolean;

    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    sput-boolean p1, Lchat/ola/vn/c/x;->h:Z

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    sget-boolean p2, Lchat/ola/vn/c/x;->h:Z

    invoke-static {p1, p2}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;Z)V

    goto/16 :goto_2

    :sswitch_e
    check-cast p2, Ljava/lang/String;

    invoke-static {p2}, Lchat/ola/vn/c/x;->a(Ljava/lang/String;)V

    :goto_1
    invoke-static {}, Lchat/ola/vn/util/c/b;->b()V

    goto/16 :goto_2

    :sswitch_f
    check-cast p2, Ljava/lang/Boolean;

    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    sput-boolean p1, Lchat/ola/vn/c/x;->q:Z

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    sget-boolean p2, Lchat/ola/vn/c/x;->q:Z

    invoke-static {p1, p2}, Lchat/ola/vn/h/b;->d(Ljava/lang/String;Z)V

    goto/16 :goto_2

    :sswitch_10
    check-cast p2, Ljava/lang/String;

    invoke-static {p2}, Ljava/lang/Byte;->valueOf(Ljava/lang/String;)Ljava/lang/Byte;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Byte;->byteValue()B

    move-result p1

    sput-byte p1, Lchat/ola/vn/c/x;->o:B

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    sget-byte p2, Lchat/ola/vn/c/x;->o:B

    invoke-static {p1, p2}, Lchat/ola/vn/h/b;->c(Ljava/lang/String;B)V

    invoke-static {}, Lchat/ola/vn/util/c/b;->c()V

    goto/16 :goto_2

    :sswitch_11
    check-cast p2, Ljava/lang/String;

    invoke-static {p2}, Ljava/lang/Byte;->valueOf(Ljava/lang/String;)Ljava/lang/Byte;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Byte;->byteValue()B

    move-result p1

    sput-byte p1, Lchat/ola/vn/c/x;->n:B

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    sget-byte p2, Lchat/ola/vn/c/x;->n:B

    invoke-static {p1, p2}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;B)V

    goto :goto_1

    :sswitch_12
    check-cast p2, Ljava/lang/String;

    invoke-static {p2}, Ljava/lang/Byte;->valueOf(Ljava/lang/String;)Ljava/lang/Byte;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Byte;->byteValue()B

    move-result p1

    sput-byte p1, Lchat/ola/vn/c/x;->m:B

    sget-byte p1, Lchat/ola/vn/c/x;->m:B

    const/4 p2, 0x3

    if-le p1, p2, :cond_1

    const/4 p1, 0x2

    sput-byte p1, Lchat/ola/vn/c/x;->m:B

    :cond_1
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    sget-byte p2, Lchat/ola/vn/c/x;->m:B

    invoke-static {p1, p2}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;B)V

    goto :goto_2

    :sswitch_13
    check-cast p2, Ljava/lang/String;

    invoke-static {p2}, Ljava/lang/Byte;->valueOf(Ljava/lang/String;)Ljava/lang/Byte;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Byte;->byteValue()B

    move-result p1

    sput-byte p1, Lchat/ola/vn/c/x;->k:B

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    sget-byte p2, Lchat/ola/vn/c/x;->k:B

    invoke-static {p1, p2}, Lchat/ola/vn/h/b;->d(Ljava/lang/String;B)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_2

    :sswitch_14
    :try_start_5
    invoke-static {p0}, Lchat/ola/vn/lock/OlaPasscodeSettingActivity;->a(Landroid/content/Context;)V

    goto :goto_2

    :sswitch_15
    const-string p1, "https://play.google.com/apps/testing/chat.ola.vn"

    invoke-static {p0, p1}, Lchat/ola/vn/util/b;->m(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_1

    goto :goto_2

    :sswitch_16
    :try_start_6
    const-string p1, "market://details?id=chat.ola.vn&write_review=true"

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    new-instance p2, Landroid/content/Intent;

    const-string v0, "android.intent.action.VIEW"

    invoke-direct {p2, v0, p1}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    invoke-virtual {p0, p2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_0

    goto :goto_2

    :catch_0
    move-exception p1

    :try_start_7
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    new-instance p1, Landroid/content/Intent;

    const-string p2, "android.intent.action.VIEW"

    invoke-direct {p1, p2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string p2, "https://play.google.com/store/apps/details?id=chat.ola.vn&write_review=true"

    invoke-static {p2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaAppSettingActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_1
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_2

    :catch_1
    :cond_2
    :goto_2
    :try_start_8
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->f:Lchat/ola/vn/b/b;

    invoke-virtual {p1}, Lchat/ola/vn/b/b;->notifyDataSetChanged()V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_2

    return-void

    :catch_2
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x13 -> :sswitch_16
        0x14 -> :sswitch_15
        0x2d -> :sswitch_14
        0x38 -> :sswitch_13
        0x3b -> :sswitch_12
        0x3f -> :sswitch_11
        0x40 -> :sswitch_10
        0x41 -> :sswitch_f
        0x42 -> :sswitch_e
        0x43 -> :sswitch_d
        0x56 -> :sswitch_c
        0x57 -> :sswitch_b
        0x5b -> :sswitch_a
        0x5c -> :sswitch_9
        0x5d -> :sswitch_8
        0x5f -> :sswitch_7
        0x64 -> :sswitch_6
        0x65 -> :sswitch_5
        0x68 -> :sswitch_4
        0x6b -> :sswitch_3
        0x6c -> :sswitch_2
        0x6e -> :sswitch_1
        0x70 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaAppSettingActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onBackPressed()V
    .locals 0

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->finish()V

    return-void
.end method

.method public onChildClick(Landroid/widget/ExpandableListView;Landroid/view/View;IIJ)Z
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->f:Lchat/ola/vn/b/b;

    invoke-virtual {p1, p3, p4}, Lchat/ola/vn/b/b;->getChild(II)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/a/c;

    invoke-virtual {p1, p0}, Lchat/ola/vn/entry/a/c;->a(Landroid/content/Context;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 p1, 0x1

    return p1
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0903a1

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 6

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const/4 p1, 0x0

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "groupIndex"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getIntent()Landroid/content/Intent;

    move-result-object v1

    const-string v2, "rowIndex"

    invoke-virtual {v1, v2, p1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    move p1, v1

    goto :goto_0

    :catch_0
    const/4 v0, 0x0

    :catch_1
    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getWindow()Landroid/view/Window;

    move-result-object v1

    new-instance v2, Landroid/graphics/drawable/ColorDrawable;

    sget v3, Lchat/ola/vn/f;->b:I

    invoke-direct {v2, v3}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v1, v2}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->B()V

    new-instance v1, Lchat/ola/vn/b/b;

    invoke-direct {v1, p0}, Lchat/ola/vn/b/b;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->f:Lchat/ola/vn/b/b;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->f:Lchat/ola/vn/b/b;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->e:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Lchat/ola/vn/b/b;->a(Ljava/util/List;)V

    const v1, 0x7f0b0020

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaAppSettingActivity;->setContentView(I)V

    const v1, 0x7f090312

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaAppSettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ExpandableListView;

    iput-object v1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->g:Landroid/widget/ExpandableListView;

    const v1, 0x7f090210

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaAppSettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/facebook/share/widget/LikeView;

    iput-object v1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->h:Lcom/facebook/share/widget/LikeView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->h:Lcom/facebook/share/widget/LikeView;

    const-string v2, "286093228187327"

    sget-object v3, Lcom/facebook/share/widget/LikeView$ObjectType;->PAGE:Lcom/facebook/share/widget/LikeView$ObjectType;

    invoke-virtual {v1, v2, v3}, Lcom/facebook/share/widget/LikeView;->setObjectIdAndType(Ljava/lang/String;Lcom/facebook/share/widget/LikeView$ObjectType;)V

    const v1, 0x7f0903a3

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaAppSettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    const v2, 0x7f0f00f9

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(I)V

    const v1, 0x7f09039c

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaAppSettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    const v1, 0x7f0903a1

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaAppSettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    const v2, 0x7f080640

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    invoke-virtual {v1, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    new-instance v1, Landroid/view/View;

    invoke-direct {v1, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    new-instance v2, Landroid/widget/AbsListView$LayoutParams;

    const/4 v3, -0x1

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    const v5, 0x7f070125

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v4

    invoke-direct {v2, v3, v4}, Landroid/widget/AbsListView$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v2}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->g:Landroid/widget/ExpandableListView;

    invoke-virtual {v2, v1}, Landroid/widget/ExpandableListView;->addFooterView(Landroid/view/View;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->g:Landroid/widget/ExpandableListView;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->f:Lchat/ola/vn/b/b;

    invoke-virtual {v1, v2}, Landroid/widget/ExpandableListView;->setAdapter(Landroid/widget/ExpandableListAdapter;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->g:Landroid/widget/ExpandableListView;

    invoke-virtual {v1, p0}, Landroid/widget/ExpandableListView;->setOnChildClickListener(Landroid/widget/ExpandableListView$OnChildClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->g:Landroid/widget/ExpandableListView;

    new-instance v2, Lchat/ola/vn/activity/OlaAppSettingActivity$1;

    invoke-direct {v2, p0}, Lchat/ola/vn/activity/OlaAppSettingActivity$1;-><init>(Lchat/ola/vn/activity/OlaAppSettingActivity;)V

    invoke-virtual {v1, v2}, Landroid/widget/ExpandableListView;->setOnGroupClickListener(Landroid/widget/ExpandableListView$OnGroupClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity;->g:Landroid/widget/ExpandableListView;

    new-instance v2, Lchat/ola/vn/activity/OlaAppSettingActivity$2;

    invoke-direct {v2, p0, p1, v0}, Lchat/ola/vn/activity/OlaAppSettingActivity$2;-><init>(Lchat/ola/vn/activity/OlaAppSettingActivity;II)V

    invoke-virtual {v1, v2}, Landroid/widget/ExpandableListView;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method protected onDestroy()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    invoke-static {}, Lchat/ola/vn/c/x;->h()V

    return-void
.end method

.method protected onPause()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/c;->onPause()V

    invoke-static {}, Lchat/ola/vn/c/x;->h()V

    return-void
.end method
