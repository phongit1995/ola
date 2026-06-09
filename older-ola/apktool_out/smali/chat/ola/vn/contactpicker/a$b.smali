.class Lchat/ola/vn/contactpicker/a$b;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/contactpicker/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field a:B

.field b:Ljava/lang/String;

.field c:Lchat/ola/vn/message/f;

.field d:Z

.field e:Z

.field f:Z

.field final synthetic g:Lchat/ola/vn/contactpicker/a;


# direct methods
.method private constructor <init>(Lchat/ola/vn/contactpicker/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/contactpicker/a$b;->g:Lchat/ola/vn/contactpicker/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    iput-byte p1, p0, Lchat/ola/vn/contactpicker/a$b;->a:B

    iput-boolean p1, p0, Lchat/ola/vn/contactpicker/a$b;->d:Z

    iput-boolean p1, p0, Lchat/ola/vn/contactpicker/a$b;->e:Z

    iput-boolean p1, p0, Lchat/ola/vn/contactpicker/a$b;->f:Z

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/contactpicker/a;Lchat/ola/vn/contactpicker/a$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/contactpicker/a$b;-><init>(Lchat/ola/vn/contactpicker/a;)V

    return-void
.end method
